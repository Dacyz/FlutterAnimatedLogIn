import 'package:fractal_technical_interview/User/models/user.dart';
import 'package:hive_flutter/adapters.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class HiveData {
  const HiveData();

  Future<int> saveUser(User user) async {
    final Box<User> box = await Hive.openBox<User>('users_box');
    return box.add(user);
  }

  Future<int> getKey(String dni) async {
    List<User?> usuarios = await users;
    User? a = usuarios.firstWhereOrNull(
      (element) => element!.dni == dni,
    );
    return usuarios.indexOf(a);
  }

  Future<int> getNewKey() async {
    List<User?> usuarios = await users;
    return usuarios.length;
  }

  Future<void> putAt(int key, User user) async {
    final Box<User> box = await Hive.openBox<User>('users_box');
    return box.putAt(key, user);
  }

  Future<List<User>> get users async {
    final Box<User> box = await Hive.openBox<User>('users_box');
    return box.values.toList();
  }
}
