import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/User.dart';
import '../models/Doctor.dart';

class UserDatabaseService {
  final Firestore _db = Firestore.instance;

  Future<User> getUser(String id) async {
    DocumentSnapshot snapshot =
        await _db.collection('users').document(id).get();
    return User.fromFirestore(snapshot);
  }

  Stream<User> streamUser(String id) {
    return _db
        .collection('users')
        .document(id)
        .snapshots()
        .map((snapshot) => User.fromFirestore(snapshot));
  }

  Future<Doctor> getDoctor(String id) async {
    DocumentSnapshot snapshot =
        await _db.collection('doctors').document(id).get();
    return Doctor.fromFirestore(snapshot);
  }

  Stream<Doctor> streamDoctor(String id) {
    return _db
        .collection('doctors')
        .document(id)
        .snapshots()
        .map((snapshot) => Doctor.fromFirestore(snapshot));
  }

  Stream<List<Doctor>> streamAllDoctors() {
    return _db.collection('doctors').snapshots().map((list) => list.documents
        .map((snapshot) => Doctor.fromFirestore(snapshot))
        .toList());
  }
}
