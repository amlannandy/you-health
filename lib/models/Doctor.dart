import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  final String userId;
  final String name;
  final String email;
  final String imageUrl;
  final String field;
  final double rating;

  Doctor({
    this.userId,
    this.name,
    this.email,
    this.imageUrl,
    this.field,
    this.rating,
  });

  factory Doctor.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    if (data == null) return null;
    Doctor doctor = Doctor(
      userId: snapshot.documentID,
      name: data['name'] ?? null,
      imageUrl: data['imageUrl'] ?? null,
      field: data['field'] ?? null,
      rating: data['rating'] ?? 3.7,
    );
    return doctor;
  }
}
