import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LoginDatabase extends StatefulWidget {
  const LoginDatabase({super.key});

  @override
  State<LoginDatabase> createState() => _LoginDatabaseState();
}

class _LoginDatabaseState extends State<LoginDatabase> {
  final TextEditingController _textController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref("Post");

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Database Example")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: "Enter some data",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: (){},
              child: const Text("Login"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
