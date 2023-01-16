import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fractal_technical_interview/User/blocs/images_data.dart';
import 'package:fractal_technical_interview/User/blocs/user_authentication.dart';
import 'package:fractal_technical_interview/User/models/user.dart';
import 'package:fractal_technical_interview/User/models/user_validation.dart';
import 'package:fractal_technical_interview/User/ui/views/login_page.dart';
import 'package:fractal_technical_interview/User/ui/widgets/animated_avatar.dart';
import 'package:fractal_technical_interview/User/ui/widgets/animated_button.dart';
import 'package:fractal_technical_interview/User/ui/widgets/animated_row.dart';
import 'package:fractal_technical_interview/User/ui/widgets/hr.dart';
import 'package:fractal_technical_interview/User/ui/widgets/list_user_container.dart';
import 'package:fractal_technical_interview/main.dart';

class UserDataPage extends StatefulWidget {
  final User? user;
  final void Function() resetUserProps;
  const UserDataPage({
    super.key,
    this.user,
    required this.resetUserProps,
  });

  @override
  State<UserDataPage> createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> with UserValidation {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameTFieldController = TextEditingController();
  TextEditingController lastNameTFieldController = TextEditingController();
  TextEditingController dniTFieldController = TextEditingController();
  TextEditingController emailTFieldController = TextEditingController();
  TextEditingController passTFieldController = TextEditingController();
  String imageFileController = '';
  String name = '';
  String lastname = '';
  String dni = '';
  String email = '';
  String pass = '';
  String image = '';

  bool isntEditable = true;
  void initData() {
    name = widget.user!.name;
    lastname = widget.user!.lastname;
    dni = widget.user!.dni;
    email = widget.user!.email;
    pass = widget.user!.pass;
    image = widget.user!.image;
    imageFileController = widget.user!.image;
  }

  @override
  void dispose() {
    nameTFieldController.dispose();
    lastNameTFieldController.dispose();
    dniTFieldController.dispose();
    emailTFieldController.dispose();
    passTFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  void _changeEditable(
    BuildContext context,
    GlobalKey<FormState> form,
    User user,
  ) async {
    if (!isntEditable) {
      if (imageFileController != '') {
        if (await LoginValidation().updateUser(user, form, context)) {
          name = nameTFieldController.text;
          dni = dniTFieldController.text;
          email = emailTFieldController.text;
          lastname = lastNameTFieldController.text;
          pass = passTFieldController.text;
          image = imageFileController;
        }
      }
    }
    isntEditable = !isntEditable;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const hr(),
                const Text(
                  'Perfil',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const hr(),
                !isntEditable
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AnimatedIconButton(
                            onPressed: () async {
                              Clipboard.setData(
                                  ClipboardData(text: widget.user.toString()));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Usuario copiado al Clipboard'),
                              ));
                            },
                            icon: Icons.file_copy,
                          ),
                          AnimatedIconButton(
                            onPressed: () async {
                              String? image =
                                  await ImageData().saveImage(context);
                              if (image != null) {
                                imageFileController = image;
                              }
                              setState(() {});
                            },
                            icon: Icons.photo_camera_back_rounded,
                          ),
                          Container(
                              decoration: image != imageFileController
                                  ? BoxDecoration(
                                      border: Border.all(
                                        color: Colors.green,
                                        width: 5,
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    )
                                  : const BoxDecoration(),
                              child: AnimatedAvatar(
                                  imageSrc: imageFileController)),
                          AnimatedIconButton(
                            onPressed: () async {
                              String? image =
                                  await ImageData().savePhoto(context);
                              if (image != null) {
                                imageFileController = image;
                              }
                              setState(() {});
                            },
                            direction: false,
                            icon: Icons.camera_alt,
                          ),
                          AnimatedIconButton(
                            onPressed: () async {
                              imageFileController = '';
                              setState(() {});
                            },
                            direction: false,
                            icon: Icons.close,
                          )
                        ],
                      )
                    : AnimatedAvatar(imageSrc: image),
                const hr(),
                AnimatedRow(
                  title: 'Nombre',
                  value: name,
                  validator: (value) =>
                      isName(value) ? 'Nombre con sintax incorrecta' : null,
                  controller: nameTFieldController,
                  isEditable: isntEditable,
                ),
                AnimatedRow(
                  title: 'Apellidos',
                  value: lastname,
                  validator: (value) =>
                      isName(value) ? 'Apellidos con sintax incorrecta' : null,
                  controller: lastNameTFieldController,
                  isEditable: isntEditable,
                ),
                AnimatedRow(
                  title: 'DNI',
                  value: dni,
                  validator: (value) =>
                      isDNI(value) ? 'DNI con sintax incorrecta' : null,
                  controller: dniTFieldController,
                  isEditable: isntEditable,
                ),
                AnimatedRow(
                  title: 'Correo',
                  value: email,
                  validator: (value) =>
                      isEmail(value) ? 'Correo con sintax incorrecta' : null,
                  controller: emailTFieldController,
                  isEditable: isntEditable,
                ),
                AnimatedRow(
                  title: 'Contraseña',
                  value: pass,
                  validator: (value) =>
                      isName(value) ? 'Contraseña con sintax incorrecta' : null,
                  controller: passTFieldController,
                  isEditable: isntEditable,
                ),
                const hr(),
                const Text(
                  'Otros usuarios',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                UserList(
                  user: widget.user,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
                onPressed: () {
                  if (isntEditable) {
                    widget.resetUserProps();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  } else {
                    isntEditable = true;
                    initData();
                    setState(() {});
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: Text(
                    isntEditable ? 'Salir' : 'Cancelar',
                    style: TextStyle(color: mainBackupColor),
                  ),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: mainBackupColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () => _changeEditable(
                  context,
                  _formKey,
                  User(
                      fecha: '',
                      image: imageFileController,
                      lastname: lastNameTFieldController.text,
                      id: widget.user!.id,
                      dni: dniTFieldController.text,
                      name: nameTFieldController.text,
                      email: emailTFieldController.text,
                      pass: passTFieldController.text)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: MediaQuery.of(context).size.width * 0.15),
                child: Text(
                  isntEditable ? 'Editar' : 'Guardar',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
