import 'package:flutter/cupertino.dart';

class TripProvider extends ChangeNotifier
{

  int fare;

  void updateFare(int fare)
  {
    this.fare = fare;
    notifyListeners();
  }


}