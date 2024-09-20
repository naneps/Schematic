import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:schematic/app/models/user.model.dart';

class UserService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<UserModel> user = UserModel().obs;

  String get uid => _auth.currentUser!.uid;

  Future<void> createUserInFirestore(
    User firebaseUser, {
    String? name,
  }) async {
    try {
      final userDoc = _firestore.collection('users').doc(firebaseUser.uid);

      final docSnapshot = await userDoc.get();
      if (!docSnapshot.exists) {
        final newUser = UserModel(
          uid: firebaseUser.uid,
          avatar: firebaseUser.photoURL ?? '',
          email: firebaseUser.email,
          name: firebaseUser.displayName ?? name ?? 'User',
          username: 'user_${firebaseUser.uid.substring(0, 5)}',
          online: true,
          typingStatus: {}, // Initialize typingStatus as an empty map
        );
        await userDoc.set(newUser.toJson());
        user.value = newUser;
        print('User created in Firestore');
      } else {
        print('User already exists in Firestore, skipping creation');
      }
    } catch (e) {
      print('Error during user creation in Firestore: $e');
    }
  }

  Future<bool> isEmailVerified() async {
    final user = _auth.currentUser;
    await user!.reload();
    return user.emailVerified;
  }

  @override
  void onClose() {
    setUserOnlineStatus(false);
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    _auth.authStateChanges().listen(_onAuthStateChanged);
    _initializeFCMToken();
  }

  void setUserIsTyping(bool isTyping, String chatRoomId) {
    final typingStatus = user.value.typingStatus ?? {};
    typingStatus[chatRoomId] = isTyping;
    user.value.typingStatus = typingStatus;
    updateUserFieldInFirestore('typingStatus', typingStatus);
  }

  Future<void> setUserOnlineStatus(bool isOnline) async {
    await updateUserFieldInFirestore('online', isOnline);
  }

  // Method to update user's FCM token in Firestore
  Future<void> updateUserFCMToken(String token) async {
    print('UPDATE USER FCM TOKEN');
    try {
      await _firestore
          .collection('users')
          .doc(user.value.uid)
          .update({'fcmToken': token});
      print('User FCM token updated in Firestore');
    } catch (e) {
      print('Error updating FCM token in Firestore: $e');
    }
  }

  Future<void> updateUserFieldInFirestore(String field, dynamic value) async {
    try {
      final userDoc = _firestore.collection('users').doc(user.value.uid);
      await userDoc.update({field: value});
      print('User $field updated in Firestore');
    } catch (e) {
      print('Error updating user $field in Firestore: $e');
    }
  }

  Future<void> updateUserInFirestore(UserModel updatedUser) async {
    try {
      final userDoc = _firestore.collection('users').doc(updatedUser.uid);
      await userDoc.update(updatedUser.toJson());
      user.value = updatedUser;
      print('User updated in Firestore');
    } catch (e) {
      print('Error updating user in Firestore: $e');
    }
  }

  void updateUserProfile({
    String? name,
    String? role,
    String? about,
    DateTime? birthday,
  }) {
    final updatedUser = user.value;
    if (name != null) updatedUser.name = name;
    if (role != null) updatedUser.role = role;
    if (about != null) updatedUser.about = about;
    if (birthday != null) updatedUser.birthday = birthday;
    updateUserInFirestore(updatedUser);
  }

  Future<UserModel?> _getUserFromFirestore(String uid) async {
    try {
      print('GET USER FROM FIRESTORE');
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        print('User found in Firestore');

        return UserModel.fromJson(userDoc.data()!);
      }
    } catch (e) {
      print('Error getting user from Firestore: $e');
    }
    return null;
  }

  void _initializeFCMToken() async {
    print('INITIALIZE FCM TOKEN');
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Get the current FCM token
    String? token = await messaging.getToken();
    print('FCM token: $token');
    updateUserFCMToken(token!);

    // Handle token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen(updateUserFCMToken);
  }

  void _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      user.value = UserModel();
      user.value.online = false;
    } else {
      _initializeFCMToken();
      user.value = (await _getUserFromFirestore(uid))!;
      user.value.online = true;
      setUserOnlineStatus(true);
    }
  }
}
