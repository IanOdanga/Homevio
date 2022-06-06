import 'package:flutter/material.dart';
import 'package:homevio/constants.dart';

class DefaultBackButton extends StatelessWidget {
  const DefaultBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Constants.kPrimaryColor),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}