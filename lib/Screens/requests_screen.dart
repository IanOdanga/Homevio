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
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('requests').snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');

          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (_, i) {
                final data = docs[i].data();
                  return ListTile(
                    dense: false,
                    visualDensity: const VisualDensity(vertical: 4),
                    title: Text("Report ID: " + data['reportid']),
                    subtitle: Text("Area Reported Missing: " +
                        data['areaReportedMissing'] +
                        "\n Date Missing: " +
                        data['dateMissing'] +
                        "\n Child Age: " +
                        data['childAge'].toString() +
                        "\n Child Name: " +
                        data['childName'] +
                        "\n Mobile Number: " +
                        data['mobileNumber'].toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => RequestHistory()));
                            },
                            icon: const Icon(
                              Icons.navigate_next_outlined,
                              size: 20.0,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                  );
                }
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}