import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/user_model.dart';
import '../utils/components/already_have_an_account_acheck.dart';
import '../utils/components/or_divider.dart';
import '../utils/components/rounded_button.dart';
import '../utils/components/rounded_input_field.dart';
import '../utils/components/rounded_password_field.dart';
import '../utils/components/social_icon.dart';
import '../widgets/progress_dialog.dart';
import 'login_screen.dart';
import '../utils/Sign Up/background.dart';

class SignUpScreen extends StatefulWidget{

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {

  final _auth = FirebaseAuth.instance;

  String? errorMessage;

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullnNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  late String email;
  late String password;
  late String confirmPass;
  late String username;
  late String fullName;
  late String telephone;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("HOMEVIO",
        style: TextStyle(
          fontFamily: "Brand Bold",
          color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "SIGNUP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Brand Bold"),
                ),
                SizedBox(height: size.height * 0.03),
                RoundInputField(
                  hintText: "Full Name",
                  controller: fullnNameController,
                  hintStyle: const TextStyle(fontFamily: "Brand-Regular"),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("Please Enter your Full Name");
                    }
                    return null;
                  },
                  onChanged: (value) {
                    fullName = value;
                    print(fullName);
                    fullnNameController.text = fullName;
                  },
                ),
                RoundInputField(
                  hintText: "Username",
                  controller: usernameController,
                  hintStyle: const TextStyle(fontFamily: "Brand-Regular"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("Please Enter a Username");
                    }
                  },
                  onChanged: (value) {
                    username = value;
                    print(username);
                    usernameController.text = username;
                  },
                ),
                RoundedInputField(
                  hintText: "Your Email",
                  controller: emailController,
                  hintStyle: const TextStyle(fontFamily: "Brand-Regular"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("Please Enter Your Email");
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter a valid email");
                    }
                    return null;
                  },
                  onChanged: (value) {
                    email = value;
                    print(email);
                    emailController.text = email;
                  },
                ),
                PhoneInputField(
                  hintText: "Phone Number",
                  controller: phoneNumberController,
                  hintStyle: const TextStyle(fontFamily: "Brand-Regular"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("Please Enter your Phone Number");
                    }
                  },
                  onChanged: (value) {
                    telephone = value;
                    phoneNumberController.text = telephone;
                  },
                ),
                RoundedPasswordField(
                  controller: confPasswordController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{8,}$');
                    if (value.isEmpty) {
                      return ("Pin is required for login");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid Pin(Min. 8 Character)");
                    }
                    if (confPasswordController.text != passwordController.text) {
                      return ("Passwords do not match!");
                    }
                  },
                  hintText: "Password",
                  hintStyle: const TextStyle(fontFamily: "Brand Bold"),
                  onChanged: (value) {
                    password = value;
                    confPasswordController.text = password;
                  },
                ),
                RoundedConfPasswordField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{8,}$');
                    if (value.isEmpty) {
                      return ("Password is required for login");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid Password(Min. 8 Character)");
                    }
                  },
                  hintText: "Confirm Password",
                  hintStyle: const TextStyle(fontFamily: "Brand Bold"),
                  onChanged: (value) {
                    password = value;
                    passwordController.text = password;
                  },
                ),
                RoundedButton(
                  text: "SIGNUP",
                  press: () {
                    signUp(emailController.text,passwordController.text);
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
                OrDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocalIcon(
                      iconSrc: "assets/icons/facebook.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/google-plus.svg",
                      press: () {},
                    ),
                  ],
                )
              ],
            ),
          )
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
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullName = fullnNameController.text;
    userModel.username = usernameController.text;
    userModel.phoneNumber = phoneNumberController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
  }
}