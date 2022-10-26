import 'package:flutter/material.dart';
import 'package:homevio/constants.dart';
import '../animation/fade_animation.dart';
import '../models/service_provider.dart';
import 'cart_screen.dart';

class ServiceProviderScreen extends StatefulWidget {
  final String? service;
  final String? room;
  final int? roomTot;
  final String? date;
  final String? addService;
  final String? selectedHour;
  final String? location;

  ServiceProviderScreen(this.service, this.room, this.roomTot, this.date,
      this.addService, this.selectedHour, this.location);

  @override
  _ServiceProviderScreenState createState() => _ServiceProviderScreenState();
}

class _ServiceProviderScreenState extends State<ServiceProviderScreen> {

  late final List<ServiceProvider> _serviceProvider = [
    ServiceProvider(widget.selectedHour ?? '', 'Michael', '5km away'),
    ServiceProvider(widget.selectedHour ?? '', 'Alexandra', '8km away'),
    /*ServiceProvider(widget.selectedHour ?? '', 'Sharon', '8km away'),
    ServiceProvider(widget.selectedHour ?? '', 'Anne', '2 km away'),*/
  ];

  String? _selectedProvider = 'Michael';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Choose Provider",
        style: TextStyle(
          fontFamily: "ubuntu",
          color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Constants.kPrimaryColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                      color: Colors.white
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(widget.date!, style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "ubuntu"
                            ),)
                          ],
                        ),
                        const SizedBox(height: 15,),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _serviceProvider.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedProvider = _serviceProvider[index].name;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                child: FadeAnimation((1.0 + index) / 4, dayTask(_serviceProvider[index].time, _serviceProvider[index].name, _serviceProvider[index].distance, index)),
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: _selectedProvider == _serviceProvider[index].name ? Colors.orange.shade100.withOpacity(0.5) : Colors.orange.withOpacity(0),
                                  border: Border.all(
                                    color: _selectedProvider == _serviceProvider[index].name ? Colors.orange : Colors.white.withOpacity(0),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            );
                          },
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(widget.service,widget.room,widget.roomTot,widget.date,widget.addService,widget.location,_selectedProvider)));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  Row dayTask(String time, String name, String distance, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width*0.2,
          child: Text(time, style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ), textAlign: TextAlign.right,),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),
            color: Constants.kAccentColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "ubuntu",
                    fontWeight: FontWeight.w700
                ),),
                const SizedBox(height: 10,),
                Text(widget.service!, style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "ubuntu",
                    fontWeight: FontWeight.w500
                ),),
                const SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.timer, color: Constants.kAccentColor,),
                    const SizedBox(width: 5,),
                    Text("$time - 5 pm", style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: "ubuntu",
                        fontWeight: FontWeight.w600
                    ),)
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: const [
                    Text("Client Rating", style: TextStyle(
                        color: Colors.black,
                        fontFamily: "ubuntu",
                        fontWeight: FontWeight.w500
                    ),),
                    SizedBox(width: 5,),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                  ],
                ),
                const SizedBox(height: 5,),
                Container(
                  height: 0.5,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.call, color: Colors.black,
                      ),
                      //onTap: ,
                    ),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      child: const Icon(
                        Icons.mail_outline, color: Colors.black,
                      ),
                      //onTap: ,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    /*const Text("\$50", style: TextStyle(
                        color: Constants.kAccentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),)*/
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}