import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homevio/constants.dart';
import 'package:homevio/models/request_model.dart';
import 'package:homevio/models/user_model.dart';
import 'package:intl/intl.dart';

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
        .doc(userRequests.requestid)
        .get()
        .then((value) {
      userRequests = RequestModel.fromMap(value.data());
      setState(() {});
    });
  }

  late QuerySnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Requests",
        style: TextStyle(
          fontFamily: "Brand Bold",
          color: Colors.black
        ),),
        centerTitle: true,
        backgroundColor: Constants.kAccentColor,
      ),
      body: Container(
        height: 500,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('requests').snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasError) return Text('Error = ${snapshot.error}');

            if (snapshot.hasData) {
              final docs = snapshot.data!.docs;
              return Expanded(
                child: ListView.builder(
                  itemCount: docs.length,
                  itemExtent: 100,
                  itemBuilder: (_, i) {
                    final data = docs[i].data();
                    return ListTile(
                      dense: false,
                      visualDensity: const VisualDensity(vertical: 4),
                      title: Text("Date Requested:  "+DateFormat('yyyy-MM-dd – kk:mm').format(data['date requested'].toDate()), style: const TextStyle(fontFamily: "ubuntu", fontWeight: FontWeight.bold)),
                      subtitle: Text("Service Type: " + data['servicetype'] + "\n Provider Name: "+ data['providerName'] + "\n Status: "+ data['job status'] + "\n Total Cost: "+ data['job cost'].toString(), style: const TextStyle(fontFamily: "ubuntu")),
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
                                color: Constants.kPrimaryColor,
                              )
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _showRequests() {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('requests').snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasError) return Text('Error = ${snapshot.error}');

            if (snapshot.hasData) {
              final docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (_, i) {
                  final data = docs[i].data();
                  return Column(
                    children: <Widget>[
                      Text(data['providerName']),
                      Text(data['servicetype']),
                      Text(data['room']),
                      Text(data['roomTotal']),
                      Text(data['location']),
                      //Text(data['phone']),
                    ],
                  );
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}

class RequestHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                return Column(
                  children: <Widget>[
                    Text(data['providerName']),
                    Text(data['servicetype']),
                    Text(data['room']),
                    Text(data['roomTotal'].toString()),
                    Text(data['location']),
                    //Text(data['phone']),
                  ],
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}