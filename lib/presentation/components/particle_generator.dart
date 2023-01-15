import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:fractal_technical_interview/main.dart';

class _Particles {
  final Color color;
  final double direction;
  final double speed;
  final double size;
  final double initialPosition;

  _Particles(
      {required this.color,
      required this.direction,
      required this.speed,
      required this.size,
      required this.initialPosition});
}

class ParticleGenerator extends StatelessWidget {
  final Animation<double> progressAnimation;
  final Animation<double> validationOutAnimation;

  final particles = List<_Particles>.generate(300, (index) {
    final size = math.Random().nextInt(20) + 5.0;
    final speed = math.Random().nextInt(50) + 0.8;
    final directionRandom = math.Random().nextBool();
    final colorRandom = math.Random().nextBool();
    final direction =
        math.Random().nextInt(250) * (directionRandom ? 1.0 : -1.0);
    final color = colorRandom ? mainBackupColor : secondaryBackupColor;

    return _Particles(
        color: color,
        direction: direction,
        speed: speed,
        size: size,
        initialPosition: index * 10.0);
  });

  ParticleGenerator(
      {super.key,
      required this.progressAnimation,
      required this.validationOutAnimation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([progressAnimation, validationOutAnimation]),
      builder: (BuildContext context, Widget? child) {
        /** 
         * Medidas del icono
        */
        final queryData = MediaQuery.of(context).size;
        final double size = queryData.width * 0.5;
        final double circleInSize = size *
            math.pow(
                (progressAnimation.value + validationOutAnimation.value + 1),
                2);
        final double centerMargin = queryData.width - circleInSize;
        final double topPosition = queryData.height * 0.45;
        final double topOutPosition =
            queryData.height * validationOutAnimation.value;
        return Positioned(
          left: 0,
          right: 0,
          top: (topPosition - circleInSize + topOutPosition),
          height: circleInSize,
          child: Stack(
            children: [
              Positioned(
                  height: circleInSize,
                  width: circleInSize,
                  left: centerMargin / 2,
                  bottom: 0,
                  child: ClipOval(
                    child: CustomPaint(
                        foregroundPainter:
                            _ParticlePainter(progressAnimation, particles),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Opacity(
                            opacity: 1 - progressAnimation.value,
                            child: const Icon(
                              Icons.person,
                              size: 120,
                            ),
                          ),
                        )),
                  )),
            ],
          ),
        );
      },
    );
  }
}

class _ParticlePainter extends CustomPainter {
  _ParticlePainter(this.animation, this.particles) : super(repaint: animation);

  final Animation<double> animation;
  final List<_Particles> particles;
  @override
  void paint(Canvas canvas, Size size) {
    for (_Particles p in particles) {
      final offset = Offset(
          size.width / 2 + p.direction * animation.value,
          size.height * 1.2 * (1 - animation.value) -
              p.speed * animation.value +
              p.initialPosition * (1 - animation.value));
      canvas.drawCircle(offset, p.size, Paint()..color = p.color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
