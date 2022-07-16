import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homevio/Screens/service_provider_screen.dart';
import 'package:homevio/constants.dart';
import 'package:http/http.dart' as http;

class ClientLocation extends StatefulWidget{
  static const String idScreen = "locationscreen";

  final String? service;
  final String? room;
  final int? roomTot;
  final String? date;
  final String? addService;
  final String? selectedHour;

  ClientLocation(this.service, this.room, this.roomTot, this.date,
      this.addService, this.selectedHour);

  @override
  LocationState createState() => LocationState();
}

class LocationState extends State<ClientLocation>{
  TextEditingController pickupTextEditingController = TextEditingController();

  String? district;
  String? locale;
  late String message;
  bool? error;
  List data = List<String>.empty();

  String? _mySelection;
  List<String> location = ["Lang'ata", "Embakasi", "Westlands", "Kasarani", "Dagoretti"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Location',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "ubuntu",
                fontSize: 20,
              ),
        ),
        backgroundColor: Constants.kPrimaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Container(
              child: DropdownButton(
                isExpanded: true,
                value: district,
                hint: const Text("Select Area",style: TextStyle(fontFamily: "ubuntu"),),
                items: location.map((clientLocation) {
                  return DropdownMenuItem(
                    child: Text(clientLocation, style: const TextStyle(fontFamily: "ubuntu"),),
                    value: clientLocation,
                  );
                }).toList(),
                onChanged: (value) {
                  district = value as String;
                  getLocationList(district.toString());
                  print(district);
                },
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              //child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: state,
                  iconSize: 30,
                  icon: (null),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  hint: const Text('Select Location', style: TextStyle(fontFamily: "ubuntu"),),
                  onChanged: (String? newValue) {
                    setState(() {
                      state = newValue!;
                      print(state);
                    });
                  },
                  items: locationList?.map((item) {
                    return DropdownMenuItem(
                      child: Text(item['name'], style: const TextStyle(fontFamily: "ubuntu"),),
                      value: item['id'].toString(),
                    );
                  }).toList() ??
                      [],
                ),
              ),
            ),
            const SizedBox(height: 30.0,),
            ElevatedButton(
              child: const Text(
                "Continue",
                style: TextStyle(color: Colors.white, fontFamily: "Brand Bold"),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: const TextStyle(
                      color: Colors.white, fontSize: 14, fontFamily: "Brand Bold"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0)),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ServiceProviderScreen(widget.service, widget.room, widget.roomTot, widget.date, widget.addService, widget.selectedHour,state.toString())));
              }
            )
          ],
        ),
      ),
    );
  }

  List? locationList;
  String? state;
  String getLocationList(String areaName) {
    List? constList;
    var locationData;

    if(areaName == "Lang'ata")
      {
        constList = [
          {'name': 'Nairobi West', 'id': "Nairobi West, Lang'ata"},
          {'name': 'South C', 'id': "South C, Lang'ata"},
          {'name': 'Karen', 'id': "Karen, Lang'ata"},
          {'name': 'Nyayo Highrise', 'id': "Nyayo Highrise, Lang'ata",},
          {'name': 'Kibera', 'id': "Kibera, Lang'ata"},
        ];

        var jsonResponse = jsonEncode(constList);
        locationData = jsonDecode(jsonResponse);
      }
    else if(areaName == "Embakasi")
    {
      constList = [
        {'id': "Umoja, Embakasi", 'name': 'Umoja'},
        {'id': "Embakasi", 'name': 'Embakasi'},
        {'id': "Dandora, Embakasi", 'name': 'Dandora'},
        {'id': "Ruai, Embakasi", 'name': 'Ruai'},
        {'id': "Buruburu, Embakasi", 'name': 'Buruburu'},
        {'id': "Kayole, Embakasi", 'name': 'Kayole'},
      ];

      var jsonResponse = jsonEncode(constList);
      locationData = jsonDecode(jsonResponse);
    }
    else if(areaName == "Westlands")
    {
      constList = [
        {'id': "Kitisuru, Westlands", 'name': 'Kitisuru'},
        {'id': "Parklands, Westlands", 'name': 'Parklands/Highridge'},
        {'id': "Karura, Westlands", 'name': 'Karura'},
        {'id': "Kangemi, Westlands", 'name': 'Kangemi'},
        {'id': "Mountain View, Westlands", 'name': 'Mountain View'},
      ];

      var jsonResponse = jsonEncode(constList);
      locationData = jsonDecode(jsonResponse);
    }
    else if(areaName == "Kasarani")
    {
      constList = [
        {'id': "Mwiki, Kasarani", 'name': 'Mwiki'},
        {'id': "Clay City, Kasarani", 'name': 'Clay City'},
        {'id': "Kasarani, Kasarani", 'name': 'Kasarani'},
        {'id': "Njiru, Kasarani", 'name': 'Njiru'},
      ];

      var jsonResponse = jsonEncode(constList);
      locationData = jsonDecode(jsonResponse);
    }
    else if(areaName == "Dagoretti")
    {
      constList = [
        {'id': "Mutu-ini, Dagoretti", 'name': 'Mutu-ini'},
        {'id': "Ngando, Dagoretti", 'name': 'Ngando'},
        {'id': "Riruta, Dagoretti", 'name': 'Riruta'},
        {'id': "Uthiru, Dagoretti", 'name': 'Uthiru'},
        {'id': "Waithaka, Dagoretti", 'name': 'Waithaka'},
      ];

      var jsonResponse = jsonEncode(constList);
      locationData = jsonDecode(jsonResponse);
    }

    setState(() {
      locationList = constList;
    });
    return locationData.toString();
  }
}

