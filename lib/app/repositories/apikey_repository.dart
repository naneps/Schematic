import 'package:firebase_database/firebase_database.dart';
import 'package:schematic/app/models/apikey_model.dart';
import 'package:schematic/app/services/firebase/firebase_rdb_service.dart';

class ApikeyRepository extends FirebaseRDbService<ApiKey> {
  bool _isUpdating = false; // Lock to prevent multiple simultaneous updates

  ApikeyRepository() : super('apikeys');

  @override
  Future<void> create(ApiKey model, {Map<String, dynamic>? data}) async {
    try {
      if (model.isDefault!.value) {
        await _resetExistingDefaultKeys();
      }
      await _addApiKey(model);
    } catch (e) {
      throw Exception('Failed to create data: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    await dbRef.child(collectionPath).child(uid).child(id).remove();
  }

  Future<ApiKey> getDefaultApiKey() async {
    final snapshot = await dbRef
        .child(collectionPath)
        .child(uid)
        .orderByChild('isDefault')
        .equalTo(true)
        .get();
    if (snapshot.exists) {
      return ApiKey.fromJson(
          snapshot.key!, Map.from(snapshot.children.first.value as Map));
    } else {
      return ApiKey();
    }
  }

  @override
  Future<List<ApiKey>> readAll() async {
    List<ApiKey> apiKeyList = [];
    try {
      DataSnapshot snapshot =
          await dbRef.child(collectionPath).child(uid).get();
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          apiKeyList.add(ApiKey.fromJson(key, Map.from(value)));
        });
      }
      return apiKeyList;
    } catch (e) {
      throw Exception('Failed to read all data: $e');
    }
  }

  @override
  Future<void> update(String id, Map<String, dynamic> updates) async {
    if (_isUpdating) {
      // Prevent multiple updates from happening at the same time
      return;
    }
    _isUpdating = true;

    try {
      if (updates['isDefault']) {
        await _resetExistingDefaultKeys(); // Ensure only one default key exists
      }

      // Firebase transaction to ensure atomic update
      await dbRef
          .child(collectionPath)
          .child(uid)
          .child(id)
          .runTransaction((currentData) {
        if (currentData == null) {
          return Transaction.abort();
        }

        final Map<String, dynamic> data =
            Map<String, dynamic>.from(currentData as Map);

        // Only allow update if the key is not already the default
        if (updates['isDefault'] == true && data['isDefault'] == true) {
          return Transaction.abort();
        }

        data.addAll(updates); // Now safely use addAll on the Map
        return Transaction.success(data);
      });

      print('Data successfully updated');
    } catch (e) {
      throw Exception('Failed to update data: $e');
    } finally {
      _isUpdating = false;
    }
  }

  // Function to add a new API key
  Future<void> _addApiKey(ApiKey data) async {
    await dbRef
        .child(collectionPath)
        .child(uid)
        .push()
        .set(data.toCreateJson());
  }

  Future<void> _resetExistingDefaultKeys() async {
    final snapshot = await dbRef
        .child(collectionPath)
        .child(uid)
        .orderByChild('isDefault')
        .equalTo(true)
        .get();

    if (snapshot.exists) {
      final existingKeys = Map<String, dynamic>.from(snapshot.value as Map);
      await Future.wait(existingKeys.entries.map((entry) async {
        final key = entry.key;
        await dbRef
            .child(collectionPath)
            .child(uid)
            .child(key)
            .update({'isDefault': false});
      }));
    }
  }
}
