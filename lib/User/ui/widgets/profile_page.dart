import 'package:flutter/material.dart';
import 'package:fractal_technical_interview/User/models/user.dart';
import 'package:fractal_technical_interview/User/ui/views/user_data_page.dart';

class ProfilePage extends AnimatedWidget {
  final User? user;
  final void Function() resetUserProps;
  const ProfilePage({
    super.key,
    required this.resetUserProps,
    required Animation<double> endingAnimation,
    this.user,
  }) : super(listenable: endingAnimation);

  double get value => (listenable as Animation).value;

  @override
  Widget build(BuildContext context) {
    return value > 0
        ? UserDataPage(
            user: user,
            resetUserProps: resetUserProps,
          )
        : const SizedBox.shrink();
  }
}
