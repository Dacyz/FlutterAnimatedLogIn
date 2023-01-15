import 'package:flutter/material.dart';
import 'package:fractal_technical_interview/domain/model/user.dart';
import 'package:fractal_technical_interview/presentation/components/AnimatedRow.dart';
import 'package:fractal_technical_interview/presentation/components/hr.dart';
import 'package:fractal_technical_interview/presentation/components/image_container.dart';

class CardContainer extends StatelessWidget {
  final User user;
  const CardContainer({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50), topLeft: Radius.circular(50)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${user.name} ${user.lastname}',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const hr(),
                  ImageContainer(imageSrc: user.image),
                  AnimatedRow(
                    title: 'DNI',
                    value: user.dni,
                    controller: TextEditingController(),
                    isEditable: true,
                  ),
                  AnimatedRow(
                    title: 'Correo',
                    value: user.email,
                    controller: TextEditingController(),
                    isEditable: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: 150,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ImageContainer(imageSrc: user.image),
              Text(
                '${user.name} ${user.lastname}',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              Text('[${user.dni}]'),
            ],
          ),
        ),
      ),
    );
  }
}
