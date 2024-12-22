import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  // Controllers
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> loginData() async {
    if (emailAddressController.text.isEmpty || passwordController.text.isEmpty) {
      return "Error: Email and Password are required.";
    }
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddressController.text.trim(),
        password: passwordController.text.trim(),
      );
 
      // Store user data in Firestore
      await firestore.collection('users').doc(credential.user!.uid).set({
        'email': emailAddressController.text.trim(),
        'username': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
      });

      return "User registered successfully!";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "Error: Weak password.";
      } else if (e.code == 'email-already-in-use') {
        return "Error: Email already in use.";
      } else {
        return "FirebaseAuth Error: ${e.message}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}
