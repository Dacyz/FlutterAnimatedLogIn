import 'package:flutter/material.dart';
import 'package:fractal_technical_interview/main.dart';

class ContainerLayout extends StatelessWidget {
  final child;

  const ContainerLayout({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Colors.white,
            backgrColor,
            backgrColor,
            Colors.white,
          ])),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: child,
      ),
    );
  }
}
