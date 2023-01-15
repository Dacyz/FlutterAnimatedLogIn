import 'package:flutter/material.dart';
import 'package:fractal_technical_interview/User/models/user.dart';
import 'package:fractal_technical_interview/User/resources/hive_data.dart';
import 'package:fractal_technical_interview/User/ui/widgets/card_container.dart';

class UserList extends StatefulWidget {
  final User? user;

  const UserList({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final HiveData hiveData = const HiveData();

  List<User> usuarios = [];
  Future<void> getData() async {
    usuarios = (await hiveData.users);
    usuarios.remove(widget.user);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      height: usuarios.isNotEmpty ? 200.0 : null,
      child: usuarios.isNotEmpty
          ? ListView.separated(
              separatorBuilder: (_, __) => const SizedBox(
                width: 10,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: usuarios.length,
              itemBuilder: (BuildContext context, int index) {
                return CardContainer(
                  user: usuarios[index],
                );
              },
            )
          : const Center(child: Text('No hay más usuarios registrados')),
    );
  }
}
