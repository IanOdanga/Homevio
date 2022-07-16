import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homevio/Screens/location_screen.dart';
import 'package:homevio/Screens/service_provider_screen.dart';
import 'package:homevio/constants.dart';
import '../widgets/rounded_bordered_container.dart';
import 'cart.dart';

class CheckoutOnePage extends StatefulWidget {
  final String? service;
  final String? room;
  final int? roomTot;
  final String? date;
  final String? addService;
  final String? selectedHour;

  const CheckoutOnePage(this.service, this.room, this.roomTot, this.date,
      this.addService, this.selectedHour);

  static const String path = "lib/src/pages/ecommerce/cart1.dart";

  @override
  _checkoutPageState createState ()=> _checkoutPageState();
}

class _checkoutPageState extends State<CheckoutOnePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              "Your plan",
              style: TextStyle(
                fontFamily: "Brand Bold",
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: RoundedContainer(
                    color: Constants.kAccentColor,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "Service Type",
                          style: TextStyle(
                            fontFamily: "ubuntu",
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          widget.service!,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: "ubuntu",
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: RoundedContainer(
                    color: Constants.kAccentColor,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "Room Type",
                          style: TextStyle(
                            fontFamily: "ubuntu",
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          widget.room!,
                          style: const TextStyle(
                            fontFamily: "ubuntu",
                            fontSize: 12.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RoundedContainer(
                    color: Constants.kAccentColor,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "No. of rooms",
                          style: TextStyle(
                            fontFamily: "ubuntu",
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          widget.roomTot.toString(),
                          style: const TextStyle(
                            fontFamily: "ubuntu",
                            fontSize: 12.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: RoundedContainer(
                    color: Constants.kAccentColor,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "Date Selected",
                          style: TextStyle(
                              fontFamily: "ubuntu",
                              fontSize: 17.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          widget.date.toString(),
                          style: const TextStyle(
                            fontFamily: "ubuntu",
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 32.0,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Constants.kSecondaryColor,
                  elevation: 5,
                  padding: const EdgeInsets.all(24.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                child: const Text("Continue", style: TextStyle(fontFamily: "Brand Bold", fontSize: 18),),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ClientLocation(widget.service,widget.room,widget.roomTot,widget.date,widget.addService,widget.selectedHour)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}