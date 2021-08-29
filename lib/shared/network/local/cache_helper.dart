// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class CacheHelper {
//   static SharedPreferences _sharedPref;
//
//   //so that I can initialize it once I Open my app
//   static init() async {
//     _sharedPref = await SharedPreferences.getInstance();
//   }
//
//   static getData({
//     @required key,
//   }) {
//     return _sharedPref.get(key);
//   }
//
//   // this method accept any data type
//   // Future<bool> return to tell me if the data is saved successfully or not
//   static Future<bool> saveData({
//     @required key,
//     @required dynamic data,
//   }) async {
//     if (data is int) return await _sharedPref.setInt(key, data);
//     if (data is double) return await _sharedPref.setDouble(key, data);
//     if (data is String) return await _sharedPref.setString(key, data);
//     if (data is bool) return await _sharedPref.setBool(key, data);
//     return null;
//   }
//
//   static Future<bool> removeData({
//     @required key,
//   }) async {
//     return await _sharedPref.remove(key);
//   }
// }
