import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homevio/Screens/admin_screen.dart';
import 'package:provider/provider.dart';

import '../Services/auth_services.dart';
import '../constants.dart';
import '../models/user_model.dart';
import '../widgets/progress_dialog.dart';

class CreateUser extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<CreateUser> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Email",
              hintStyle: const TextStyle(fontFamily: "Brand Bold"),
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          TextFormField(
            controller: fullNameController,
            decoration: InputDecoration(
              hintText: "Full Name",
              hintStyle: const TextStyle(fontFamily: "Brand Bold"),
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              hintText: "Username",
              hintStyle: const TextStyle(fontFamily: "Brand Bold"),
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(fontFamily: "Brand Bold"),
            ),
          ),
          TextFormField(
            controller: phoneNumberController,
            decoration: InputDecoration(
              hintText: "Phone Number",
              hintStyle: const TextStyle(fontFamily: "Brand Bold"),
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          TextFormField(
            controller: roleController,
            decoration: InputDecoration(
              hintText: "Role",
              hintStyle: const TextStyle(fontFamily: "Brand Bold"),
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              String email = emailController.text.trim();
              String password = passwordController.text.trim();
              String role = roleController.text.trim();

              context.read<AuthService>().signUp(email, password, role);
            },
            child: Container(
              height: 50,
              width: 100,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  "Create User",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signUp(String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
      print(error.code);
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return ProgDialog(message: "Creating account...");
        }
    );
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = emailController.text;
    userModel.uid = user?.uid;
    userModel.fullName = fullNameController.text;
    userModel.username = usernameController.text;
    userModel.phoneNumber = phoneNumberController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => AdminScreen()),
            (route) => false);
  }
}