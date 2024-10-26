import 'package:schematic/app/models/user_gradient.model.dart';
import 'package:schematic/app/services/firebase/firebase_rdb_service.dart';

class GradientRepository extends FirebaseRDbService<UserGradientModel> {
  GradientRepository()
      : super(
          'user_gradients',
        );
  Future<void> createGradient(UserGradientModel gradient) {
    final data = gradient.copyWith(uid: uid);
    return super.create(data, data: data.toJson()).then((value) {
      print('Data successfully created');
    }).catchError((error) {
      print('Failed to create data: $error');
    }).whenComplete(() {
      print('Request completed');
    });
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
}
