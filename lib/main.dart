import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fractal_technical_interview/User/models/user.dart';
import 'package:fractal_technical_interview/init_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

const mainBackupColor = Color.fromARGB(255, 0, 153, 38);
const secondaryBackupColor = Color.fromARGB(255, 95, 228, 117);
const backgrColor = Color.fromARGB(255, 205, 255, 236);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return InitPage();
  }
}
