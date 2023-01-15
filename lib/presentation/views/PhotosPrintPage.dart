import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class PhotosPrintPage extends StatefulWidget {
  const PhotosPrintPage({super.key});

  @override
  State<PhotosPrintPage> createState() => _PhotosPrintPageState();
}

enum WidgetState { none, loading, loaded, error }

class _PhotosPrintPageState extends State<PhotosPrintPage> {
  //Inicializamos la cam en estado none antes del initstate
  WidgetState _widgetState = WidgetState.none;
  //Creamos arreglo de variables camaras debido a la cantidad de cámaras que tiene un celular
  List<CameraDescription> _cameras = <CameraDescription>[];
  //Camera controler
  late CameraController _cameraController;

  @override
  void initState() {
    // Para iniicalizar la cam al abrir la pant
    super.initState();
    initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    //Switch para evaluar el estado
    switch (_widgetState) {
      case WidgetState.none:
      case WidgetState.loading:
        return _builScaffold(
            context,
            const Center(
              child: CircularProgressIndicator(),
            ));
      case WidgetState.loaded:
        return _builScaffold(context, CameraPreview(_cameraController));
      case WidgetState.error:
        return _builScaffold(
            context,
            const Center(
              child: Text(
                  "La camara no se pudo inicializar. Reinica la aplicacion"),
            ));
    }
  }

  //Hacemos una funcion para el scaffold
  Widget _builScaffold(BuildContext context, Widget body) {
    return Scaffold(
      //UiAppbar
      body: SafeArea(child: body),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          XFile xfile = await _cameraController.takePicture();
          Navigator.pop(context, xfile.path);
        },
        child: Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //Metodo Inicializar camera
  Future initializeCamera() async {
    //actualiza el estado de none a loading
    _widgetState = WidgetState.loading;
    //verificar si es que el widget ya se ejecuto
    if (mounted) setState(() {});
    //activar camaras
    _cameras = await availableCameras();
    //selecionar camara y resolucion
    _cameraController = CameraController(_cameras[0], ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.yuv420, enableAudio: false);
    //Inicializar camara await obliga a que si o si se inicialize
    await _cameraController.initialize();
    //Preguntar al controller si es que hay algun error
    if (_cameraController.value.hasError) {
      _widgetState = WidgetState.error;
      if (mounted) setState(() {});
      //Si es que no se cambia el estado de loading a loaded
    } else {
      _widgetState = WidgetState.loaded;
      //verificar si es que el widget ya se ejecuto
      if (mounted) setState(() {});
    }
  }
}
