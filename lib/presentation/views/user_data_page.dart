import 'package:flutter/material.dart';
import 'package:fractal_technical_interview/data/hive_data.dart';
import 'package:fractal_technical_interview/domain/model/images_data.dart';
import 'package:fractal_technical_interview/domain/model/user.dart';
import 'package:fractal_technical_interview/main.dart';
import 'package:fractal_technical_interview/presentation/components/AnimatedRow.dart';
import 'package:fractal_technical_interview/presentation/components/card_container.dart';
import 'package:fractal_technical_interview/presentation/components/hr.dart';
import 'package:fractal_technical_interview/presentation/components/image_container.dart';
import 'package:fractal_technical_interview/presentation/views/login_page.dart';

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

class _UserDataPageState extends State<UserDataPage> {
  final HiveData hiveData = const HiveData();
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

  List<User> usuarios = [];
  bool editable = false;

  @override
  void dispose() {
    nameTFieldController.dispose();
    lastNameTFieldController.dispose();
    dniTFieldController.dispose();
    emailTFieldController.dispose();
    passTFieldController.dispose();
    super.dispose();
  }

  void initData() {
    name = widget.user!.name;
    lastname = widget.user!.lastname;
    dni = widget.user!.dni;
    email = widget.user!.email;
    pass = widget.user!.pass;
    image = widget.user!.image;
    imageFileController = widget.user!.image;
  }

  Future<void> getData() async {
    usuarios = await hiveData.users;
  }

  @override
  void initState() {
    getData();
    initData();
    super.initState();
  }

  void _changeEditable() async {
    if (!editable) {
      if (imageFileController != '') {
        await hiveData.updateUser(
            widget.user!.id,
            User(
                fecha: '',
                image: imageFileController,
                lastname: lastNameTFieldController.text,
                id: widget.user!.id,
                dni: dniTFieldController.text,
                name: nameTFieldController.text,
                email: emailTFieldController.text,
                pass: passTFieldController.text));
        name = nameTFieldController.text;
        dni = dniTFieldController.text;
        email = emailTFieldController.text;
        lastname = lastNameTFieldController.text;
        pass = passTFieldController.text;
        image = imageFileController;
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Editado correctamente'),
        ));
      }
    }
    editable = !editable;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const hr(),
              const Text(
                'Perfil de usuario',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const hr(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  !editable
                      ? IconButton(
                          onPressed: () async {},
                          icon: const Icon(Icons.file_copy),
                        )
                      : const SizedBox(),
                  !editable
                      ? IconButton(
                          icon: const Icon(Icons.photo),
                          onPressed: () {},
                        )
                      : const SizedBox(),
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
                      child: ImageContainer(imageSrc: imageFileController)),
                  !editable
                      ? IconButton(
                          onPressed: () async {
                            imageFileController =
                                await ImageData().savePhoto(context) ?? '';
                            setState(() {});
                          },
                          icon: const Icon(Icons.camera_alt),
                        )
                      : const SizedBox(),
                  !editable
                      ? IconButton(
                          onPressed: () async {
                            imageFileController = '';
                            setState(() {});
                          },
                          icon: const Icon(Icons.close),
                        )
                      : const SizedBox()
                ],
              ),
              const hr(),
              const Text(
                'Información',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const hr(),
              AnimatedRow(
                title: 'Nombre',
                value: name,
                controller: nameTFieldController,
                isEditable: editable,
              ),
              AnimatedRow(
                title: 'Apellidos',
                value: lastname,
                controller: lastNameTFieldController,
                isEditable: editable,
              ),
              AnimatedRow(
                title: 'DNI',
                value: dni,
                controller: dniTFieldController,
                isEditable: editable,
              ),
              AnimatedRow(
                title: 'Correo',
                value: email,
                controller: emailTFieldController,
                isEditable: editable,
              ),
              AnimatedRow(
                title: 'Contraseña',
                value: pass,
                controller: passTFieldController,
                isEditable: editable,
              ),
              const hr(),
              const Text(
                'Otros usuarios',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                height: 200.0,
                child: usuarios.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (_, __) => const SizedBox(
                          width: 10,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: usuarios.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (usuarios[index].id == widget.user!.id) {
                            return const SizedBox();
                          }
                          return CardContainer(
                            user: usuarios[index],
                          );
                        },
                      )
                    : const Center(
                        child: Text('No hay más usuarios registrados')),
              ),
            ],
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
                  widget.resetUserProps();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: const Text(
                    'Salir',
                    style: TextStyle(color: mainBackupColor),
                  ),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: mainBackupColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: _changeEditable,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: MediaQuery.of(context).size.width * 0.15),
                child: Text(
                  editable ? 'Editar' : 'Guardar',
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