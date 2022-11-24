import 'package:flutter/material.dart';
import '../constants.dart';
import '../utils/components/already_have_an_account_acheck.dart';
import '../utils/components/background.dart';
import '../utils/components/rounded_button.dart';
import '../utils/components/rounded_password_field.dart';
import 'login_screen.dart';

class ChangePinScreen extends StatefulWidget {

  @override
  _ChangePinScreenState createState() => _ChangePinScreenState();
}
class _ChangePinScreenState extends State<ChangePinScreen> {

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  String oldPassword = '';
  String newPassword = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Reset Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Brand Bold"),
                ),
                SizedBox(height: size.height * 0.03),
                Image.asset(
                  Constants.PIN_GIF_IMAGE,
                  height: size.height * 0.35,
                ),
                RoundedPasswordField(
                  controller: oldPasswordController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{4,}$');
                    if (value.isEmpty) {
                      return ("Pin is required for login");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid Pin(Min. 4 Character)");
                    }
                  },
                  hintText: "Old Password",
                  hintStyle: const TextStyle(fontFamily: "Brand Bold"),
                  onChanged: (value) {
                    oldPassword = value;
                    oldPasswordController.text = oldPassword;
                  },
                ),
                RoundedPasswordField(
                  controller: newPasswordController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{4,}$');
                    if (value.isEmpty) {
                      return ("Password is required for login");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid Password(Min. 4 Character)");
                    }
                  },
                  hintText: "New Password",
                  hintStyle: const TextStyle(fontFamily: "Brand Bold"),
                  onChanged: (value) {
                    newPassword = value;
                    newPasswordController.text = newPassword;
                  },
                ),
                RoundedButton(
                  text: "Reset Password",
                  press: () {},
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
              ],
            ),
          )
      ),
    );
  }
}
