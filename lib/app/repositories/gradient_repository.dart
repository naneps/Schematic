import 'package:schematic/app/models/user_gradient.model.dart';
import 'package:schematic/app/services/firebase/firebase_rdb_service.dart';

class GradientRepository extends FirebaseRDbService<UserGradientModel> {
  GradientRepository() : super('user_gradients');
  Future<void> createGradient(UserGradientModel gradient) {
    final data = gradient.copyWith(userId: uid);
    return super
        .create(data, data: data.toJson())
        .then((value) {})
        .catchError((error) {})
        .whenComplete(() {});
  }

  Future<void> deleteGradient(String id) async {
    try {
      await dbRef.child(collectionPath).child(id).remove();
      print('Data successfully deleted');
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }

  Stream<List<UserGradientModel>> getPublicGradients() {
    try {
      return dbRef
          .child(collectionPath)
          .orderByChild('published')
          .equalTo(true)
          .onValue
          .map((event) {
        if (event.snapshot.children.isNotEmpty) {
          return event.snapshot.children
              .map((e) =>
                  UserGradientModel.fromJson(e.key!, Map.from(e.value as Map)))
              .toList();
        }
        return [];
      });
    } catch (e) {
      // TODO
      throw Exception('Failed to stream data: $e');
    }
  }

  Stream<List<UserGradientModel>> getUserGradients() {
    try {
      return dbRef
          .child(collectionPath)
          .orderByChild('userId')
          .equalTo(uid)
          .onValue
          .map((event) {
        if (event.snapshot.children.isNotEmpty) {
          return event.snapshot.children
              .map((e) =>
                  UserGradientModel.fromJson(e.key!, Map.from(e.value as Map)))
              .toList();
        }
        return [];
      });
    } catch (e) {
      // TODO
      throw Exception('Failed to stream data: $e');
    }
  }

  Future<void> onLikeGradient(String id) async {
    try {
      // Mendapatkan referensi child dari data gradient berdasarkan ID
      final gradientRef = dbRef.child(collectionPath).child(id);
      final snapshot = await gradientRef.child('likedBy').get();

      if (snapshot.value != null && (snapshot.value as Map).containsKey(uid)) {
        // Jika `uid` sudah ada di `likedBy`, hapus (unlike)
        await gradientRef.child('likedBy/$uid').remove();
        await gradientRef
            .child('likeCount')
            .set((snapshot.value as Map).length - 1);
      } else {
        // Jika `uid` belum ada di `likedBy`, tambahkan (like)
        await gradientRef.child('likedBy/$uid').set(true);
        await gradientRef
            .child('likeCount')
            .set((snapshot.value as Map? ?? {}).length + 1);
      }

      print('Gradient successfully liked/unliked');
    } catch (e) {
      throw Exception('Failed to like/unlike gradient: $e');
    }
  }

  Future<void> saveGradient(String id) async {
    final gradientDoc = dbRef.child(collectionPath).child(id);
    final snapshot = await gradientDoc.child('savedBy').get();
    if (snapshot.value != null && (snapshot.value as Map).containsKey(uid)) {
      await gradientDoc.child('savedBy/$uid').remove();
      await gradientDoc
          .child('savedCount')
          .set((snapshot.value as Map).length - 1);
    } else {
      await gradientDoc.child('savedBy/$uid').set(true);
      await gradientDoc
          .child('savedCount')
          .set((snapshot.value as Map? ?? {}).length + 1);
    }
  }

  Future<void> updateGradient(String id, Map<String, dynamic> updates) async {
    try {
      await dbRef.child(collectionPath).child(id).update(updates);
      print('Data successfully updated');
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }
}
