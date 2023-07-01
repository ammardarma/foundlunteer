import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var a = prefs.getString('token');
    return a;
  }
}
