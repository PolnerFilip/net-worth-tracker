import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  // --- sign in, up and out
  Future<String> signIn(String email, String password) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    User? user = result.user;
    return user?.uid ?? '';
  }

  Future<String> signUp(String email, String password) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = result.user;
    return user?.uid ?? '';
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
