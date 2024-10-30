import 'package:schematic/app/models/user_gradient.model.dart';
import 'package:schematic/app/services/firebase/firebase_rdb_service.dart';

class GradientRepository extends FirebaseRDbService<UserGradientModel> {
  GradientRepository() : super('user_gradients');
  Future<void> createGradient(UserGradientModel gradient) {
    final data = gradient.copyWith(uid: uid);
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
          .orderByChild('uid')
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

  Future<void> updateGradient(String id, Map<String, dynamic> updates) async {
    try {
      await dbRef.child(collectionPath).child(id).update(updates);
      print('Data successfully updated');
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }
}
