import 'package:flutter/cupertino.dart';
import 'package:sida_app/shared/network/local/cache_helper.dart';

enum HomeStatus {
  INITIAL,
  SELECT_AND_CONFIRM_RIDE,
  FINDING_RIDE,
  DRIVER_ARRIVING,
  DRIVER_ARRIVED,
}

class DataProvider extends ChangeNotifier{

  static bool _isEnglish = CacheHelper.getIsEnglishData();
  bool get isEnglish => _isEnglish;
  String carType = 'defaultCarType';


  void updateCarType(String type){
    carType = type;
    print('update car type to '+ type + carType);
    notifyListeners();
  }
   void setIsEnglishChosen (bool value) async {
     _isEnglish = value;
     CacheHelper.saveData(key: "isEnglish", data: value);
     print("setIsEnglishChosen: " + _isEnglish.toString());
     notifyListeners();
  }
  void toggleLanguage () async {
    _isEnglish = !_isEnglish;
    CacheHelper.saveData(key: "isEnglish",
        data: _isEnglish);
    print("toggleLanguage: " + _isEnglish.toString());
    notifyListeners();
  }

  // static getIsEnglishSharedPrefData({
  //   @required key,
  // }) {
  //
  //   return _sharedPref.get(key)?? true;
  // }

  HomeStatus _homeStatus = HomeStatus.INITIAL;
  HomeStatus get homeStatus => _homeStatus;

  void updateHomeStatus(HomeStatus value) {
    _homeStatus = value;
    print('home status updated to : ' + value.toString());
    notifyListeners();
  }

}