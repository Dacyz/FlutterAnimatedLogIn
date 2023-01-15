import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String dni;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String lastname;
  @HiveField(4)
  final String email;
  @HiveField(5)
  final String pass;
  @HiveField(6)
  final bool isActive;
  @HiveField(7)
  final String image;
  @HiveField(8)
  final String fecha;

  User({
    required this.image,
    required this.fecha,
    required this.lastname,
    required this.id,
    required this.dni,
    required this.name,
    required this.email,
    this.isActive = true,
    this.pass = 'New User',
  });

  dynamic toJson() => {
        'id': id,
        'dni': dni,
        'name': name,
        'email': email,
        'image': image,
        'fecha': fecha,
        'isActive': isActive,
        "customerType": pass,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object> get props {
    return [name, dni, email, isActive, pass, image];
  }
}
