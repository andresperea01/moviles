import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/universidad.dart';

class UniversidadService {
  static const String collectionName = 'universidades';

  final FirebaseFirestore _firestore;

  UniversidadService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection(collectionName);

  Stream<List<Universidad>> watchUniversidades() {
    return _collection.orderBy('nombre').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Universidad.fromFirestore(doc.id, doc.data()),
              )
              .toList(),
        );
  }

  Future<String> create(Universidad universidad) async {
    final doc = await _collection.add(universidad.toFirestore());
    return doc.id;
  }

  Future<void> update(Universidad universidad) async {
    if (universidad.id == null) {
      throw ArgumentError('El id es requerido para actualizar');
    }
    await _collection.doc(universidad.id).update(universidad.toFirestore());
  }

  Future<void> delete(String id) async {
    await _collection.doc(id).delete();
  }
}
