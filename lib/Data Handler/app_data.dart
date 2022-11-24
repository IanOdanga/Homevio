import 'package:flutter/cupertino.dart';

import '../models/address.dart';

class AppData extends ChangeNotifier{

  Address? pickUpLocation;
  Address? driverlocation;

  void updatePickUpLocationAddress(Address pickUpAddress)
  {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }
  void DriverAddress(Address driverAddress)
  {
    driverlocation = driverAddress;
    notifyListeners();
  }
}