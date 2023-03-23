import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required bool isPsychologist,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    CollectionReference ref = _firebaseFirestore.collection('users');
    print("REGISTERING ${ref.doc(currentUser!.uid).id}");
    ref.doc(currentUser!.uid).set({'email': email, 'name': name, 'role': isPsychologist ? 'psychologist' : 'user', 'premium': 'false'});
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
