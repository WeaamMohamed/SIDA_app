import 'package:flutter/cupertino.dart';

class TripProvider extends ChangeNotifier
{

  int fare;
  int _waitingTime;

  void updateFare(int fare)
  {
    this.fare = fare;
    notifyListeners();
  }

  // void updateWaitingTime(int waitingTime)
  // {
  //   this.waitingTime = waitingTime;
  //   notifyListeners();
  // }

}