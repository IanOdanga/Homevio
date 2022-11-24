import 'package:flutter/material.dart';

class Constants {
  static const Color PRIMARY_COLOR = Color(0xff97EAD2);
  static const String OTP_GIF_IMAGE = "assets/otp.gif";
  static const String PIN_GIF_IMAGE = "assets/images/Pinreset.gif";
  static const Color kPrimaryColor = Color(0xFF97EAD2);
  static const kPrimaryLightColor = Color(0xFFF1E6FF);
  static const Color textPrimaryColor = Color(0xFFF0F0F0);
  static const Color kAccentColor = Color(0xFF8CC7A1);
  static const Color MenuColor = Color(0xFF00A9A5);
  static const Color SecondaryColor = Color(0xFF0B5351);
  static const Color kSecondaryColor = Color(0xFF1B4353);
  static const kDarkColor = Color(0xFF092327);
  static const String success = 'assets/images/success.gif';

  static const kDefaultPadding = 24.0;
  static const kLessPadding = 10.0;
  static const kFixPadding = 16.0;
  static const kLess = 4.0;
  static const kRadius = 0.0;

  static const kTransparent = Colors.transparent;

  static const kShape = 30.0;

  static const kSubTextStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
    fontFamily: "ubuntu",
  );

  static const kDarkTextStyle = TextStyle(
    fontSize: 20.0,
    color: kDarkColor,
    fontWeight: FontWeight.bold,
    fontFamily: "ubuntu",
  );

  static final paymentLabels = [
    'Credit card / Debit card',
    'Cash on delivery',
    'MPESA',
    'Paypal',
  ];

  static final paymentIcons = [
    Icons.credit_card,
    Icons.money_off,
    Icons.payment,
    Icons.account_balance_wallet,
  ];
}