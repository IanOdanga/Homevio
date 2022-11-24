import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homevio/models/request_model.dart';
import 'package:homevio/models/user_model.dart';

class Requests extends StatefulWidget {

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> with SingleTickerProviderStateMixin{
  static String idScreen = "requests";

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  RequestModel userRequests = RequestModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("requests")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.userRequests = RequestModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Requests',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          backgroundColor: Colors.black,
        ),
    );
  }
}