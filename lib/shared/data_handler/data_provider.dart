import 'package:flutter/cupertino.dart';

enum HomeStatus {
  INITIAL,
  SELECT_AND_CONFIRM_RIDE,
  FINDING_RIDE,
  DRIVER_ARRIVING,
  DRIVER_ARRIVED,
}

class DataProvider extends ChangeNotifier{
  HomeStatus _homeStatus = HomeStatus.INITIAL;


  HomeStatus get homeStatus => _homeStatus;

  set homeStatus(HomeStatus value) {
    _homeStatus = value;
    notifyListeners();
  }


}