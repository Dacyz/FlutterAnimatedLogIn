import 'package:flutter/material.dart';
import 'package:fractal_technical_interview/User/blocs/user_authentication.dart';
import 'package:fractal_technical_interview/User/ui/views/register_page.dart';
import 'package:fractal_technical_interview/User/ui/widgets/animated_avatar.dart';
import 'package:fractal_technical_interview/User/ui/widgets/custom_textfield.dart';
import 'package:fractal_technical_interview/User/ui/widgets/hr.dart';
import 'package:fractal_technical_interview/User/ui/widgets/layout_page.dart';
import 'package:fractal_technical_interview/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _keepSesion = false;
  TextEditingController dniTFController = TextEditingController();
  TextEditingController passTFController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutPage(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  'Ingresa los datos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: TweenAnimationBuilder(
                    builder: (context, value, child) => Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 50.0 * value),
                        child: Transform.translate(
                            offset: const Offset(0, -150), child: child),
                      ),
                    ),
                    duration: const Duration(milliseconds: 500),
                    tween: Tween(begin: 0.0, end: 1.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const AnimatedAvatar(),
                          const hr(height: 24),
                          CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingresa tu nombre de usuario';
                                }
                                return null;
                              },
                              controller: dniTFController,
                              icon: Icons.person,
                              hint: 'DNI'),
                          const hr(),
                          CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingresa tu clave';
                                }
                                return null;
                              },
                              controller: passTFController,
                              icon: Icons.lock,
                              hint: 'Contraseña',
                              passType: true),
                          const hr(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: _keepSesion,
                                activeColor: mainBackupColor,
                                onChanged: (value) {
                                  setState(() {
                                    _keepSesion = value ?? false;
                                  });
                                },
                              ),
                              const Text(
                                ' Mantener sesión abierta',
                                style: TextStyle(
                                  color: mainBackupColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                ' Recuperar aquí.',
                                style: TextStyle(
                                  color: mainBackupColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              const hr(height: 12),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage()));
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1 -
                                        12),
                            child: const Text(
                              'Registrame',
                              style: TextStyle(color: mainBackupColor),
                            ),
                          )),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainBackupColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () => LoginValidation().loginUser(
                            dniTFController.text,
                            passTFController.text,
                            _keepSesion,
                            _formKey,
                            context),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.1),
                          child: const Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
