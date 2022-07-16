import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homevio/Screens/payment_screen.dart';
import 'package:homevio/Screens/success_screen.dart';
import 'package:homevio/constants.dart';
import 'package:homevio/models/request_model.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CartPage extends StatefulWidget {
  final String? service;
  final String? room;
  final int? roomTot;
  final String? date;
  final String? addService;
  final String? location;
  final String? providerName;

  CartPage(this.service, this.room, this.roomTot, this.date, this.addService, this.location, this.providerName);

  @override
  _CartPageState createState() => _CartPageState();

}

class _CartPageState extends State<CartPage> {

  late final List<Map> items = [
    {
      "title":"${widget.service} ${widget.room} (${widget.roomTot})",
      "price": _priceCalculator(widget.room!,widget.service!,widget.roomTot!),
    }
  ];

  late int total = _priceCalculator(widget.room!,widget.service!,widget.roomTot!);
  late double serviceFee = _serviceFeeCalculator(total);
  late double subtotal = total + serviceFee.toDouble();

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 30.0),
                child: Text("CART", style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700
                ),)),
            Expanded(child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index){
                return Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(right: 30.0, bottom: 10.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(5.0),
                        elevation: 3.0,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 80,
                                ///child: PNetworkImage(items[index]["image"]),
                              ),
                              const SizedBox(width: 10.0,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(items[index]["title"], style: const TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: "ubuntu",
                                        fontWeight: FontWeight.bold
                                    ),),
                                    const SizedBox(height: 20.0,),
                                    Text("Ksh. ${items[index]['price']}", style: const TextStyle(
                                        fontFamily: "ubuntu",
                                        fontSize: 18.0
                                    ),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 15,
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          padding: const EdgeInsets.all(0.0),
                          color: Constants.kAccentColor,
                          child: const Icon(Icons.clear, color: Colors.white,),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                );
              },

            ),),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("Subtotal    Ksh. $total", style: TextStyle(
                      color: Colors.grey.shade700,
                      fontFamily: "ubuntu",
                      fontSize: 16.0
                  ),),
                  const SizedBox(height: 5.0,),
                  Text("Service fee     Ksh. $serviceFee", style: TextStyle(
                      color: Colors.grey.shade700,
                      fontFamily: "ubuntu",
                      fontSize: 16.0
                  ),),
                  const SizedBox(height: 10.0,),
                  Text("Cart Subtotal   Ksh. $subtotal", style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "ubuntu",
                      fontSize: 18.0
                  ),),
                  const SizedBox(height: 20.0,),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      height: 50.0,
                      color: Constants.SecondaryColor,
                      child: Text("Secure Checkout".toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "ubuntu",
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                      onPressed: (){
                        postDetailsToFirestore();
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => Payment()));
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _priceCalculator(String room, String serviceType, int roomTotal) {
    int price = 0;
    if (serviceType == "Cleaning") {
      if (room == "Bedroom") {
        price = 300*widget.roomTot!;
      }
      else if (room == "Bathroom") {
        price = 200*widget.roomTot!;
      }
    }
    else if (serviceType == "Electrician") {
      if (room == "Bedroom") {
        price = 300*widget.roomTot!;
      }
      else if (room == "Bathroom") {
        price = 200*widget.roomTot!;
      }
      else if (room == "Living Room") {
        price = 500;
      }
      else if (room == "Kitchen") {
        price = 200;
      }
      else if (room == "Office") {
        price = 300;
      }
    }
    else if (serviceType == "Plumber") {
      if (room == "Bedroom") {
        price = 300*widget.roomTot!;
      }
      else if (room == "Bathroom") {
        price = 200*widget.roomTot!;
      }
      else if (room == "LivingRoom") {
        price = 500;
      }
      else if (room == "Kitchen") {
        price = 200;
      }
      else if (room == "Office") {
        price = 300;
      }
    }
    else if (serviceType == "Painter") {
      if (room == "Bedroom") {
        price = 300*widget.roomTot!;
      }
      else if (room == "Bathroom") {
        price = 200*widget.roomTot!;
      }
      else if (room == "LivingRoom") {
        price = 500;
      }
      else if (room == "Kitchen") {
        price = 200;
      }
      else if (room == "Office") {
        price = 300;
      }
    }
    else if (serviceType == "Carpenter") {

    }
    else if (serviceType == "Gardener") {

    }
    else if (serviceType == "Tailor") {

    }
    else if (serviceType == "Maid") {
      if (room == "Bedroom") {
        price = 300*widget.roomTot!;
      }
      else if (room == "Bathroom") {
        price = 200*widget.roomTot!;
      }
      else if (room == "LivingRoom") {
        price = 500;
      }
      else if (room == "Kitchen") {
        price = 200;
      }
      else if (room == "Office") {
        price = 300;
      }
    }
    else if (serviceType == "Driver") {

    }
    else if (serviceType == "Cook") {

    }
    return price;
  }

  _serviceFeeCalculator(int totalPrice) {
    double servFee = (5 * totalPrice)/100;

    return servFee;
  }

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    RequestModel requestModel = RequestModel();

    requestModel.servicetype = widget.service;
    requestModel.uid = user?.uid;
    requestModel.requestid = getRandomString(20);
    requestModel.location = widget.location;
    requestModel.dateRequested = DateTime.now();
    requestModel.roomTotal = widget.roomTot;
    requestModel.providerName = widget.providerName;
    requestModel.room = widget.room;

    await firebaseFirestore
        .collection("requests")
        .doc(requestModel.requestid)
        .set(requestModel.toMap());
    //Fluttertoast.showToast(msg: "Request Successful :) ");
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        message: 'Processing...',
        borderRadius: 6.0,
        backgroundColor: Colors.white,
        progressWidget: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Constants.kPrimaryColor),),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        textAlign: TextAlign.center,
        padding: const EdgeInsets.all(15.0),
        maxProgress: 100.0,
        progressTextStyle: const TextStyle(
            color: Colors.black, fontFamily: "Brand Bold"),
        messageTextStyle: const TextStyle(
            color: Colors.black, fontFamily: "Brand Bold")
    );

    await pr.hide();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              height: 90,
              decoration: const BoxDecoration(
                color: Color(0xFF36827F),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 48,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Success!",
                          style: TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: "ubuntu",),
                        ),
                        Spacer(),
                        Text(
                          "Request Successful",
                          style: TextStyle(fontSize: 12.0, color: Colors.white, fontFamily: "ubuntu"),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
                child: SvgPicture.asset("assets/icons/bubbles.svg",
                  height: 48,
                  width: 40,
                  color: const Color(0xFF295147),
                ),
              ),
            ),
            Positioned(
              top: -20,
              left: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/icons/success.png",
                    height: 40,
                  ),
                  Positioned(
                    top: 10,
                    child: SvgPicture.asset(
                      "assets/icons/close.svg",
                      height: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => Success()),
            (route) => false);
  }
}