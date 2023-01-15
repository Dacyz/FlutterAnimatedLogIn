import 'package:shared_preferences/shared_preferences.dart';

class SPreferencesData {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;

  late String userSesion;
  late String passSesion;
  late bool keepSesionLogin;

  SPreferencesData();

  void resetUserProps() {
    keepSesionLogin = false;
    userSesion = '';
    passSesion = '';
    writeUserProps(userSesion, passSesion, keepSesionLogin);
  }

  Future<bool> writeUserProps(String user, String pass, bool KeepLogin) async {
    prefs = await _prefs;
    final bool userS = await prefs.setString('userSesion', user);
    final bool passS = await prefs.setString('passSesion', pass);
    final bool keepS = await prefs.setBool('keepSesion', KeepLogin);
    return userS && passS && keepS;
  }

  Future<void> readUserProps() async {
    prefs = await _prefs;
    userSesion = prefs.getString('userSesion') ?? '';
    passSesion = prefs.getString('passSesion') ?? '';
    keepSesionLogin = prefs.getBool('keepSesion') ?? false;
  }
}
