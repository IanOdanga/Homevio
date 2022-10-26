import 'package:flutter/material.dart';
import 'package:homevio/constants.dart';
import '../widgets/default_button.dart';
import '../widgets/empty_section.dart';
import '../widgets/subtitle.dart';
import 'home_screen.dart';

class Success extends StatefulWidget {
  Success({Key? key}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kPrimaryLightColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EmptySection(
            emptyImg: Constants.success,
            emptyMsg: 'Successful !!',
          ),
          const SubTitle(
            subTitleText: 'Your booking was done successfully',
          ),
          DefaultButton(
            btnText: 'Ok',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}