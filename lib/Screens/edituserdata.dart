import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  final String? uid;

  EditUser({Key? key, this.uid}) : super(key: key);
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController roleController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: roleController,
            decoration: InputDecoration(
              hintText: "Role...",
              hintStyle: const TextStyle(fontFamily: "ubuntu"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              hintText: "Username...",
              hintStyle: const TextStyle(fontFamily: "ubuntu"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              String newRole = roleController.text.trim();
              String newUsername = usernameController.text.trim();

              FirebaseFirestore.instance.collection('users').doc(widget.uid).update({
                'role': newRole,
                'username': newUsername,
              });
            },
            child: Container(
              height: 50,
              width: 100,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  "UPDATE DATA",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
