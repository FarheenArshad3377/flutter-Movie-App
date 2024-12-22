import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stacked_app/screens/home/homeview.dart';

class SignModel extends ChangeNotifier {
  TextEditingController emailAddress_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
 signModel(BuildContext context) async {
  if (emailAddress_controller.text.isEmpty || password_controller.text.isEmpty) {
    print("Email and Password cannot be empty.");
    return;
  }
  notifyListeners();
  try {
    setLoading(true);
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress_controller.text,
      password: password_controller.text,
    );
    print("User registered: ${credential.user?.uid}");
   notifyListeners();
    // Check if the user is created successfully
    if (credential.user != null) {
      print('User created successfully, navigating to HomeView...');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
      notifyListeners();
    } else {
      print("Failed to create user.");
    }
    notifyListeners();
  } on FirebaseAuthException catch (e) {
    print('FirebaseAuthException: ${e.message}');
  notifyListeners();
  } 
  catch (e) {
    print('Error: $e');
    notifyListeners();
  }
   finally {
    setLoading(false);
    notifyListeners();
  }
}



}
