import 'package:fractal_technical_interview/resources/hive_data.dart';
import 'package:fractal_technical_interview/models/user_validation.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:fractal_technical_interview/models/user.dart';

class LoginValidation with UserValidation {
  Future<User?> getUser(String dni) async {
    List<User?> usuarios = await const HiveData().users;
    return usuarios.firstWhereOrNull((element) => element!.dni == dni);
  }

  Future<bool> isUser(String dni) async {
    List<User> usuarios = await const HiveData().users;
    return usuarios.any((element) => element.dni == dni);
  }

  Future<User?> isValidateLogin(String dni, String pass) async {
    User? user = await LoginValidation().getUser(dni);
    if (user == null) return null;
    if (user.pass == pass) return user;
    return null;
  }
}
