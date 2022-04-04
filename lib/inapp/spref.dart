import 'package:shared_preferences/shared_preferences.dart';

class SPref {
  SPref._internal();
  static final SPref instance = SPref._internal();

  Future<void> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, value);
  }

  Future<void> setStringList(
      String productId, List<String> listPurchases) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(productId, listPurchases);
  }

  Future<List<String>> getStringList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(key) ?? [];
  }
}
