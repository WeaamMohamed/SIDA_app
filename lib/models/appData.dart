
import 'package:flutter/cupertino.dart';
import 'package:sida_app/models/history.dart';

class AppData extends ChangeNotifier
{
  String earnings = "0";
  int countTrips = 0;
  List<String> tripHistoryKeys = [];
  List<myHistory> tripHistoryDataList = [];


  void updateEarnings(String updatedEarnings)
  {
    earnings = updatedEarnings;
    notifyListeners();
  }

  void updateTripsCounter(int tripCounter)
  {
    countTrips = tripCounter;
    notifyListeners();
  }

  void updateTripKeys(List<String> newKeys)
  {
    tripHistoryKeys = newKeys;
    notifyListeners();
  }

  void updateTripHistoryData(myHistory eachHistory)
  {
    tripHistoryDataList.add(eachHistory);
    notifyListeners();
  }
}