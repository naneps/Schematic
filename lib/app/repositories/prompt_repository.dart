import 'package:firebase_database/firebase_database.dart'; // Tambahkan impor ini
import 'package:get/get.dart';
import 'package:schematic/app/commons/ui/overlays/x_snackbar.dart';
import 'package:schematic/app/models/user_prompot.dart';
import 'package:schematic/app/services/firebase/firebase_rdb_service.dart';
import 'package:schematic/app/services/user_service.dart';

class PromptRepository extends FirebaseRDbService<UserPromptModel> {
  final userService = Get.find<UserService>();
  PromptRepository() : super('prompts');

  @override
  Future<void> create(UserPromptModel data) async {
    try {
      await dbRef.child(collectionPath).push().set(data.toJson()).then((_) {
        XSnackBar.show(
          context: Get.context!,
          message: 'Data successfully created',
          type: SnackBarType.success,
        );
      });
      print('Data successfully created');
    } catch (e) {
      print('Failed to create data: $e');
      XSnackBar.show(
        context: Get.context!,
        message: 'Failed to create data',
        type: SnackBarType.error,
      );
      throw Exception('Failed to create data: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await dbRef.child(collectionPath).child(id).remove();
      print('Data successfully deleted');
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }

  @override
  Future<UserPromptModel?> read(String id) async {
    try {
      DataSnapshot snapshot = await dbRef.child(collectionPath).child(id).get();
      if (snapshot.value != null) {
        return UserPromptModel.fromJson(snapshot.value as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to read data: $e');
    }
  }

  @override
  Future<List<UserPromptModel>> readAll() async {
    List<UserPromptModel> promptList = [];
    try {
      DatabaseEvent event = await dbRef
          .child(collectionPath)
          .orderByChild('userId')
          .equalTo(userService.user.value.uid)
          .once();

      DataSnapshot dataSnapshot = event.snapshot;

      if (dataSnapshot.value != null) {
        // Cast the returned map to Map<dynamic, dynamic>
        Map<dynamic, dynamic> values =
            dataSnapshot.value as Map<dynamic, dynamic>;

        values.forEach((key, value) {
          if (value is Map) {
            Map<String, dynamic> json = Map<String, dynamic>.from(value);
            promptList.add(UserPromptModel.fromMap(
              key as String,
              json,
            ));
          }
        });
      }
      return promptList;
    } catch (e) {
      throw Exception('Failed to read all data: $e');
    }
  }

  @override
  Future<void> update(String id, Map<String, dynamic> updates) async {
    try {
      await dbRef.child(collectionPath).child(id).update(updates);
      print('Data successfully updated');
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }
}
