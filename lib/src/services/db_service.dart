import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/meditation.dart';
import '../models/user_data.dart';

class DBService {
  static DBService instance = DBService();

  late FirebaseFirestore _db;

  DBService() {
    _db = FirebaseFirestore.instance;
  }

  final String _userCollection = "Users";
  final String _meditationCollection = "Audios";

  Future<void> createUserInDB(
      String uid, String name, String email, bool isPsychologist) async {
    try {
      return await _db.collection(_userCollection).doc(uid).set({
        "name": name,
        "email": email,
        "role": (isPsychologist) ? "psychologist" : "user",
        "premium": false,
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<UserData> getUserData(String uid) {
    var ref = _db.collection(_userCollection).doc(uid);
    return ref.get().asStream().map((snapshot) {
      return UserData.fromFirestore(snapshot);
    });
  }

  Stream<List<Meditation>> getMeditations() {
    var ref = _db.collection(_meditationCollection);
    return ref.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Meditation.fromFirestore(doc);
      }).toList();
    });
  }
}
