import 'package:get/get.dart';
import 'package:schematic/app/models/user_gradient.model.dart';
import 'package:schematic/app/services/firebase/cloud_firestore_service.dart';
import 'package:schematic/app/services/user_service.dart';

class GradientRepository2 extends FirestoreService<UserGradientModel> {
  final userService = Get.find<UserService>();
  GradientRepository2() : super('gradients');
  Future<void> createGradient(UserGradientModel gradient) async {
    try {
      final data = gradient.copyWith(userId: userService.uid);
      super.addItem(data.toJson());
    } catch (e) {
      throw Exception('Failed to create gradient: $e');
    }
  }

  Future<void> deleteGradient(String id) async {
    try {
      super.deleteItem(id);
    } catch (e) {
      throw Exception('Failed to delete gradient: $e');
    }
  }

  @override
  UserGradientModel fromFirestore(
      Map<String, dynamic> data, String documentId) {
    return UserGradientModel.fromJson(documentId, data);
  }

  Future<void> onLikeGradient(String docId) async {
    try {
      final gradientRef = collection.doc(docId);

      // Run transaction using FirebaseFirestore instance
      await instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(gradientRef);
        if (!snapshot.exists) {
          throw Exception('Gradient not found');
        }
        Map<String, dynamic> likedBy = snapshot.data()?['likedBy'] ?? {};
        int likeCount = snapshot.data()?['likeCount'] ?? 0;

        if (likedBy.containsKey(userService.uid)) {
          likedBy.remove(userService.uid);
          likeCount = (likeCount - 1)
              .clamp(0, likeCount); // Ensure count doesn't go negative
        } else {
          likedBy[userService.uid] = true;
          likeCount += 1;
        }

        // Update the document with new likedBy and likeCount values
        transaction.update(gradientRef, {
          'likedBy': likedBy,
          'likeCount': likeCount,
        });
      });

      print('Gradient successfully liked/unliked');
    } catch (e) {
      throw Exception('Failed to like/unlike gradient: $e');
    }
  }

  saveGradient(String s) {}

  Stream<List<UserGradientModel>> streamUserGradients(
      {Map<String, dynamic>? filters = const {}}) {
    try {
      return super.streamItems(filters: {
        'userId': userService.uid,
        ...filters!,
      });
    } catch (e) {
      throw Exception('Failed to stream gradients: $e');
    }
  }

  Future<void> updateGradient(String id, Map<String, dynamic> updates) async {
    try {
      super.updateItem(id, updates);
    } catch (e) {
      throw Exception('Failed to update gradient: $e');
    }
  }
}
