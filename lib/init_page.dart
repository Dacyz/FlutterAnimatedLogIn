import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fractal_technical_interview/User/blocs/user_authentication.dart';
import 'package:fractal_technical_interview/User/models/user.dart';
import 'package:fractal_technical_interview/User/resources/SPreferences_data.dart';
import 'package:fractal_technical_interview/User/ui/views/login_page.dart';
import 'package:fractal_technical_interview/User/ui/widgets/start_page.dart';

class InitPage extends StatelessWidget {
  InitPage({super.key});
  final SPreferencesData prefs = SPreferencesData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: prefs.readUserProps(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (prefs.keepSesionLogin) {
            return FutureBuilder<User?>(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    return StartPage(user: snapshot.data);
                  }
                }
                return const LoginPage();
              },
              future: LoginValidation()
                  .isValidateLogin(prefs.userSesion, prefs.passSesion),
            );
          }
        }
        return const LoginPage();
      },
    );
  }
}
