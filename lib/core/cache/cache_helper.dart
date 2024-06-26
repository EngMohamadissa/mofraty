import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

//! Here The Initialize of cache .
  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveCartData(double totalCost, double progressValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('totalCost', totalCost);
    await prefs.setDouble('progressValue', progressValue);
  }

  Future<void> resetCartData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('totalCost');
    await prefs.remove('progressValue');
  }

  Future<double> getSavedTotalCost() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('totalCost') ?? 0.0;
  }

  Future<double> getSavedProgressValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('progressValue') ?? 0.0;
  }
}
