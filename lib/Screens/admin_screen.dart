import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homevio/constants.dart';

import 'create_user_screen.dart';
import 'edituserdata.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController emailController = TextEditingController();

  String email = " ";
  String uid = " ";
  String role = " ";
  String fullName = " ";
  String username = " ";

  bool ableToEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome Admin", style: TextStyle(fontFamily: "Brand Bold"),),
            const SizedBox(height: 50,),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(fontFamily: "ubuntu")
              ),
            ),
            GestureDetector(
              onTap: () async {
                String userEmail = emailController.text.trim();

                final QuerySnapshot snap = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: userEmail).get();
                setState(() {
                  email = userEmail;
                  uid = snap.docs[0]['uid'];
                  role = snap.docs[0]['role'];
                  fullName = snap.docs[0]['fullName'];
                  username = snap.docs[0]['username'];

                  ableToEdit = true;
                });
              },
              child: Container(
                height: 50,
                width: 100,
                color: Constants.kAccentColor,
                child: const Center(
                  child: Text(
                    "Get User Data",
                    style: TextStyle(
                      fontFamily: "ubuntu"
                    ),
                  ),
                ),
              ),
            ),
            ableToEdit ? GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditUser(uid: uid,)));
              },
              child: Container(
                height: 50,
                width: 100,
                color: Constants.kAccentColor,
                child: const Center(
                  child: Text(
                    "Edit User",
                    style: TextStyle(
                        fontFamily: "ubuntu"
                    ),
                  ),
                ),
              ),
            ) : Container(),
            GestureDetector(
              onTap: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUser()));
              },
              child: Container(
                height: 50,
                width: 100,
                color: Constants.kAccentColor,
                child: const Center(
                  child: Text(
                    "Create User",
                    style: TextStyle(
                        fontFamily: "ubuntu"
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50,),
            const Text('User Data :'),
            const SizedBox(height: 50,),
            Text('Email : ' + email, style: const TextStyle(fontFamily: "ubuntu"),),
            Text('UID : ' + uid, style: const TextStyle(fontFamily: "ubuntu"),),
            Text('Role : ' + role, style: const TextStyle(fontFamily: "ubuntu"),),
            Text('Full Name : ' + fullName, style: const TextStyle(fontFamily: "ubuntu"),),
            Text('Username : ' + username, style: const TextStyle(fontFamily: "ubuntu"),),
          ],
        ),
      ),
    );
  }
}