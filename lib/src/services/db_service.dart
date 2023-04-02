import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_health_app/src/models/favorite.dart';
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
  final String _favouritesCollection = "Favourites";

  Future<void> createUserInDB(
      String uid, String name, String email, bool isPsychologist) async {
    try {
      return await _db.collection(_userCollection).doc(uid).set({
        "name": name,
        "email": email,
        "role": (isPsychologist) ? "psychologist" : "user",
        "premium": false,
        "last_audio": "",
        "sessions": 0,
        "minutes": 0,
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

  Future<void> updateUserData(String uid, int minutes, int sessions, String lastAudio ) {
    return _db.collection(_userCollection).doc(uid).update({
      "minutes": minutes,
      "sessions": sessions,
      "last_audio": lastAudio,
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

  Stream<Meditation> getAudio(String id) {
    var ref = _db.collection(_meditationCollection).doc(id);
    return ref.get().asStream().map((snapshot) {
      return Meditation.fromFirestore(snapshot);
    });
  }

  Stream<List<Favorite>> getFavourites(String uid) {
    var ref = _db.collection(_userCollection).doc(uid).collection(_favouritesCollection);
    return ref.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Favorite.fromFirestore(doc);
      }).toList();
    });
  }

  Future<void> setFavourite(String uid, String a_id, String title, int duration, bool premium, String image, String link, String category) {
    return _db.collection(_userCollection).doc(uid).collection(_favouritesCollection).add({
      "a_id": a_id,
      "title": title,
      "duration": duration,
      "premium": premium,
      "image": image,
      "link": link,
      "category": category,
    });
  }

  Future<void> removeFavourite(String uid, String fid) {
    return _db.collection(_userCollection).doc(uid).collection(_favouritesCollection).doc(fid).delete();
  }

  Future<void> removeFavouriteByAudioId(String uid, String aid) {
    return _db.collection(_userCollection).doc(uid).collection(_favouritesCollection).where("a_id", isEqualTo: aid).get().then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
      });
    });
  }

  Stream<List<AppointmentRequest>> getRequests(String uid, String role, String status) {
    Query<Map<String, dynamic>> ref;
    if (role == "user") {
       ref = _db.collection(_requestCollection).where("from", isEqualTo: uid);
    } else {
      print(uid);
       ref = _db.collection(_requestCollection).where("to", isEqualTo: uid).where("status", isEqualTo: status);
    }
    return ref.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return AppointmentRequest.fromFirestore(doc);
      }).toList();
    });
  }

  Future<void> updateRequest(String id, String status) {
    return _db.collection(_requestCollection).doc(id).update({
      "status": status
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
