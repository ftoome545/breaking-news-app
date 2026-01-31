import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/home/data/models/news_model.dart';

class SharedPreferencesService {
  static late SharedPreferences _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static setString(String key, String value) async {
    await _instance.setString(key, value);
  }

  static String getString(String key) {
    return _instance.getString(key) ?? '';
  }

  static removeString(String key) async {
    await _instance.remove(key);
  }

  static void setBool(String key, bool value) async {
    await _instance.setBool(key, value);
  }

  static bool getBool(String key) {
    return _instance.getBool(key) ?? false;
  }

  static Future<void> setNewsList(String key, List<NewsModel> newsList) async {
    final List<Map<String, dynamic>> jsonList =
        newsList.map((news) => news.toJson()).toList();

    final List<String> stringList =
        jsonList.map((jsonMap) => jsonEncode(jsonMap)).toList();

    await _instance.setStringList(key, stringList);
  }

  static List<NewsModel> getNewsModel(String key) {
    final List<String>? stringList = _instance.getStringList(key);

    if (stringList == null) {
      return [];
    }

    final List<Map<String, dynamic>> jsonList = stringList
        .map((jsonString) => json.decode(jsonString) as Map<String, dynamic>)
        .toList();

    final List<NewsModel> newsList =
        jsonList.map((jsonMap) => NewsModel.fromJson(jsonMap)).toList();

    return newsList;
  }

  static Future<bool> setNotifications(String key, bool value) async {
    return await _instance.setBool(key, value);
  }

  static bool getNotifications(String key) {
    return _instance.getBool(key) ?? true;
  }
}
