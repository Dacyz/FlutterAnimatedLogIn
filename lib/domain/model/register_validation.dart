import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fractal_technical_interview/data/hive_data.dart';
import 'package:fractal_technical_interview/domain/model/user.dart';

class RegisterValidation extends HiveData {
  Future<void> registerUser(
      User user, GlobalKey<FormState> a, BuildContext context) async {
    if (a.currentState!.validate()) {
      try {
        User newUser = User(
            fecha: '',
            image: user.image,
            lastname: user.lastname,
            id: await getNewKey(),
            dni: user.dni,
            name: user.name,
            email: user.email,
            pass: user.pass);
        await saveUser(newUser);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Registrado correctamente"),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              const Text("Ocurrio un error al intentar registrar el usuario"),
          action: SnackBarAction(
            label: 'Copiar error',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: e.toString()));
            },
          ),
        ));
      }
    }
  }
}
