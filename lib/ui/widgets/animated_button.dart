import 'package:flutter/material.dart';

class AnimatedIconButton extends StatelessWidget {
  final void Function() onPressed;
  final bool direction;
  final IconData icon;

  const AnimatedIconButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      this.direction = true});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      builder: (_, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset:
              Offset(direction ? 20.0 * value : -20.0 * value, 20.0 * value),
          child: Transform.translate(
              offset: Offset(direction ? -20.0 : 20.0, -20.0), child: child),
        ),
      ),
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0.7, end: 1.0),
      child: IconButton(onPressed: onPressed, icon: Icon(icon)),
    );
  }
}
