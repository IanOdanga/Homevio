import 'package:flutter/material.dart';
import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: SignUpBody(),
    );
  }
}