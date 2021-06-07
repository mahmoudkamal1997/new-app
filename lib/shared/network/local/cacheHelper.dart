import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper{

  static SharedPreferences sharedPreferences;

  static void init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoulean({@required String key ,@required bool value})async
  {
    return await sharedPreferences.setBool(key, value);

  }

  static bool getBoolean({@required String key})
  {
    return sharedPreferences.getBool(key);
  }
}