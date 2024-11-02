import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreService<T> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath;

  FirestoreService(this.collectionPath);
  get collection => _firestore.collection(collectionPath);
  get instance => _firestore;
  Future<void> addItem(Map<String, dynamic> data) async {
    final docRef = _firestore.collection(collectionPath).doc();
    await docRef.set(data);
  }

  // Delete a document by ID
  Future<void> deleteItem(String id) async {
    final docRef = _firestore.collection(collectionPath).doc(id);
    await docRef.delete();
  }

  T fromFirestore(Map<String, dynamic> data, String documentId);
// Fetch a document by ID
  Future<Map<String, dynamic>?> getItemById(String id) async {
    final docRef = _firestore.collection(collectionPath).doc(id);
    final snapshot = await docRef.get();

    return snapshot.exists ? snapshot.data() : null;
  }

  // Stream documents with optional filters and ordering
  Stream<List<T>> streamItems({
    Map<String, dynamic>? filters,
    String? orderBy,
    bool descending = false,
  }) {
    Query query = _firestore.collection(collectionPath);

    // Apply filters
    if (filters != null) {
      filters.forEach((key, value) {
        query = query.where(key, isEqualTo: value);
      });
    }

    // Apply ordering
    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }

    return query.snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) =>
                    fromFirestore(doc.data() as Map<String, dynamic>, doc.id),
              )
              .toList(),
        );
  }

  // Update an existing document
  Future<void> updateItem(String id, Map<String, dynamic> data) async {
    final docRef = _firestore.collection(collectionPath).doc(id);
    await docRef.update(data);
  }
}
