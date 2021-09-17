import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sida_app/shared/data_handler/data_provider.dart';

class CacheHelper {
  static SharedPreferences _sharedPref;

  //so that I can initialize it once I Open my app
  static init() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  static bool getDataIsEnglish({
    key = 'isEnglish',
    @required context,

  }) {
    Provider.of<DataProvider>(context, listen: false).setIsEnglishChosen(_sharedPref.get(key)?? true);
    return Provider.of<DataProvider>(context).isEnglish;
  }

  static getIsEnglishData({
    key = 'isEnglish',

  }) {
    return _sharedPref.get(key)?? true;
  }

  static getData({
    key,
  }) {
    return _sharedPref.get(key);
  }
static Future<bool> saveData({
  @required key,
  @required bool data,
}) async {

  return await _sharedPref.setBool(key, data);

}



}
