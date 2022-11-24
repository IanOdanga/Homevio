import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homevio/Data%20Handler/request_assistant.dart';
import 'package:provider/provider.dart';

import '../models/address.dart';
import '../models/config.dart';
import '../models/directions_details.dart';
import 'app_data.dart';

class AssistantMethods{
  static Future<String> searchCoordinateAddress(Position position, BuildContext context) async
  {
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url="https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude},&key=$apiKey";

    var response = await RequestAssistant.getRequest(url);

    if(response != "failed")
    {
      st1= response["results"][0]["address_components"][4]["long_name"];
      st2= response["results"][0]["address_components"][7]["long_name"];
      st3= response["results"][0]["address_components"][6]["long_name"];
      st4= response["results"][0]["address_components"][9]["long_name"];
      placeAddress= st1 + ", "+ st2 + ", " + st3 + ", " + st4;

      Address userPickupAddress = Address(placeId: '', placeName: '', longitude: position.longitude, latitude: position.latitude, placeFormattedAddress: '');
      userPickupAddress.longitude = position.longitude;
      userPickupAddress.latitude = position.latitude;
      userPickupAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickupAddress);
    }

    return placeAddress;
  }

  static Future<DirectionsDetails?> obtainPlaceDirections(LatLng initialPosition, LatLng finalPosition) async
  {
    String directionUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude}${initialPosition.longitude}&destination=${finalPosition.latitude}${finalPosition.longitude}&key=$apiKey";

    var response = await RequestAssistant.getRequest(directionUrl);

    if(response != "failed")
    {
      return null;
    }

    DirectionsDetails directionsDetails = DirectionsDetails(distanceText: '', durationValue: 0, encodedPoints: '', durationText: '', distanceValue: 0);

    directionsDetails.encodedPoints = response["routes"][0]["overview_polyline"]["points"];

    directionsDetails.distanceText = response["routes"][0]["legs"][0]["distance"]["text"];
    directionsDetails.distanceValue = response["routes"][0]["legs"][0]["distance"]["value"];

    directionsDetails.durationText = response["routes"][0]["legs"][0]["duration"]["text"];
    directionsDetails.durationValue = response["routes"][0]["legs"][0]["duration"]["text"];

    return directionsDetails;
  }
}