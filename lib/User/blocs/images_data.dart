import 'dart:io';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fractal_technical_interview/User/ui/widgets/PhotosPrintPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageData {
  ///
  /// Clase para el registro de Imagenes en el directorio de la aplicación.
  ///
  /// Uses cases:
  /// - Obtener fotografia.
  /// - Obtener imagen de la galeria.
  /// - Guardar en el directorio de la aplicación.
  ///

  Future<String?> savePhoto(BuildContext context) async {
    String? paths = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PhotosPrintPage()));
    if (paths == null) return null;
    return saveFile(XFile(paths));
  }

  Future<String?> saveImage(BuildContext context) async {
    XFile? Image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (Image == null) return null;
    return saveFile(Image);
  }

  Future<String?> saveFile(XFile pickedFile) async {
    try {
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      File file = File(
          path.join(documentDirectory.path, path.basename(pickedFile.path)));
      await file.writeAsBytes(await pickedFile.readAsBytes());
      return file.path;
    } catch (e) {
      return null;
    }
  }
}
