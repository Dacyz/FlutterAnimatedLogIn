import 'package:flutter/material.dart';

class ProgressCounter extends AnimatedWidget {
  const ProgressCounter(Animation<double> animation, {super.key})
      : super(listenable: animation);

  double get value => (listenable as Animation).value;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value > 0.5 ? 'Validando datos ...' : 'Validando registros ...',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${(value * 100).truncate().toString()}%',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 52,
            ),
          ),
        ],
      );
}
