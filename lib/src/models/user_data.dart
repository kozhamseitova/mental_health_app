import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String id;
  final String email;
  final String name;
  final bool isPremium;
  final String role;


  UserData({required this.id, required this.email, required this.name, required this.isPremium, required this.role});

  factory UserData.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return UserData(id: snapshot.id, email: data["email"], name: data["name"], isPremium: false, role: data["role"]);
  }
}