import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userId;
  final String name;
  final String email;
  final String imageUrl;

  User({
    this.userId,
    this.name,
    this.email,
    this.imageUrl,
  });

  factory User.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    if (data == null) return null;
    User user = User(
      userId: snapshot.documentID,
      name: data['name'] ?? null,
      imageUrl: data['imageUrl'] ?? null,
      email: data['email'] ?? null,
    );
    return user;
  }
}
