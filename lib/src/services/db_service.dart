import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_health_app/src/models/request.dart';

import '../models/meditation.dart';
import '../models/user_data.dart';

enum Category {
  meditation,
  story,
  sleep
}

class DBService {
  static DBService instance = DBService();

  late FirebaseFirestore _db;

  DBService() {
    _db = FirebaseFirestore.instance;
  }

  final String _userCollection = "Users";
  final String _meditationCollection = "Audios";
  final String _requestCollection = "Requests";

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

  Future<UserData> getUserDataOnce(String uid) {
    var ref = _db.collection(_userCollection).doc(uid);
    return ref.get().then((value)
      {
        return UserData.fromFirestore(value);
      }
    );
  }

  Stream<List<UserData>> getUsers(String role) {
    var ref = _db.collection(_userCollection).where("role", isEqualTo: role);
    return ref.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserData.fromFirestore(doc);
      }).toList();
    });
  }


  Stream<List<Meditation>> getAudios(Category category) {
    var ref = _db.collection(_meditationCollection).where("category", isEqualTo: category.name);
    return ref.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Meditation.fromFirestore(doc);
      }).toList();
    });
  }

  Stream<List<AppointmentRequest>> getRequests() {
    var ref = _db.collection(_requestCollection);
    return ref.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return AppointmentRequest.fromFirestore(doc);
      }).toList();
    });
  }

  Future<void> sendRequest(String to, String from, String toName, String fromName, String contact, String desc) {
    return _db.collection(_requestCollection).add({
      "to": to,
      "from": from,
      "to_name": toName,
      "from_name": fromName,
      "description": desc,
      "status": "отправлено",
      "contact": contact,
    });
  }

}
