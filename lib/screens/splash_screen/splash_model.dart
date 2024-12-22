import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stacked/stacked.dart';

class SplashModel extends BaseViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool isUserLoggedIn = false;

  Future<void> initialize() async {
    setBusy(true); // Set the ViewModel state to busy
    await _initializeFirebase();
    isUserLoggedIn = _firebaseAuth.currentUser != null;
    setBusy(false); // Set the ViewModel state to idle
  }

  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print("Firebase initialization failed: $e");
    }
  }
}
