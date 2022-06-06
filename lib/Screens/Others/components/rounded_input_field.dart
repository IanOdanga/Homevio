import 'package:flutter/material.dart';
import 'package:homevio/Screens/Others/components/text_field_container.dart';

import '../../../constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.mail,
    required this.onChanged, required TextEditingController controller, required TextInputType keyboardType, required String? Function(String value) validator, required TextStyle hintStyle,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: Constants.kPrimaryColor,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Constants.kPrimaryColor,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(fontFamily: "Brand-Regular"),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
class RoundInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.mail,
    required this.onChanged, required TextEditingController controller, required TextInputType keyboardType, required String? Function(String value) validator, required TextStyle hintStyle,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: Constants.kPrimaryColor,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Constants.kPrimaryColor,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(fontFamily: "Brand-Regular"),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
class PhoneInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const PhoneInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.phone,
    required this.onChanged, required TextEditingController controller, required TextInputType keyboardType, required String? Function(String value) validator, required TextStyle hintStyle,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: Constants.kPrimaryColor,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Constants.kPrimaryColor,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(fontFamily: "Brand-Regular"),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
