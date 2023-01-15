import 'dart:io';

import 'package:flutter/material.dart';

class AnimatedAvatar extends StatelessWidget {
  final String? imageSrc;

  const AnimatedAvatar({
    Key? key,
    this.imageSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      builder: (_, value, child) => Opacity(
        opacity: value,
        child: Transform.scale(
          scale: 1 * value,
          child: Transform.scale(scale: 1, child: child),
        ),
      ),
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0.7, end: 1.0),
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: imageSrc != null && imageSrc != ''
            ? CircleAvatar(
                backgroundColor: Colors.white,
                radius: 45,
                child: ClipOval(
                  child: Image.file(
                    File(imageSrc ?? ''),
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  ),
                ),
              )
            : const Icon(
                Icons.person,
                size: 42,
              ),
      ),
    );
  }
}
