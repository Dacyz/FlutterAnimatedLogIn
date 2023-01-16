import 'package:flutter/material.dart';
import 'package:fractal_technical_interview/User/models/catch_error.dart';
import 'package:fractal_technical_interview/User/models/user.dart';
import 'package:fractal_technical_interview/User/models/user_validation.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:fractal_technical_interview/User/resources/spreferences_data.dart';
import 'package:fractal_technical_interview/User/resources/hive_data.dart';
import 'package:fractal_technical_interview/User/ui/widgets/start_page.dart';

class LoginValidation extends HiveData with UserValidation, CatchError {
  ///
  /// Clase para la authentificación del usuario:
  ///
  /// Uses cases:
  /// - Registro de usuario.
  /// - Actualización de datos del usuario.
  /// - Inicio de Sesión del usuario.
  ///

  Future<bool> registerUser(
      User user, GlobalKey<FormState> form, BuildContext context) async {
    if (form.currentState!.validate()) {
      return catchs(
        () async {
          User newUser = User(
              fecha: '',
              image: user.image,
              lastname: user.lastname,
              id: await getNewKey(),
              dni: user.dni,
              name: user.name,
              email: user.email,
              pass: user.pass);
          return (await saveUser(newUser)) != -1;
        },
        context: context,
        onError: 'Ocurrio un error al Registrar',
        onSuccess: 'Registro satisfactorio',
      );
    }
    return false;
  }

  Future<bool> updateUser(
      User user, GlobalKey<FormState> form, BuildContext context) async {
    if (form.currentState!.validate()) {
      return catchs(
        () async {
          return await putAt(user.id, user);
        },
        context: context,
        onError: 'Ocurrio un error al actualizar datos',
        onSuccess: 'Actualización satisfactoria',
      );
    }
    return false;
  }

  Future<void> loginUser(String dni, String pass, bool keepSesion,
      GlobalKey<FormState> form, BuildContext context) async {
    if (form.currentState!.validate()) {
      final User? userValidated =
          await LoginValidation().isValidateLogin(dni, pass);
      final bool comprobation =
          await SPreferencesData().writeUserProps(dni, pass, keepSesion);
      if (comprobation && userValidated != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StartPage(user: userValidated)));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('El usuario o contraseña incorrectos'),
        ));
      }
      form.currentState!.reset();
    }
  }

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
