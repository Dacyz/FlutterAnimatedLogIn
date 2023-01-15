import 'package:flutter/material.dart';
import 'package:fractal_technical_interview/main.dart';

class CustomTextField extends StatefulWidget {
  final IconData? icon;
  final String hint;
  final TextEditingController controller;
  final bool passType;
  final String? value;
  final String? Function(String?)? validator;

  const CustomTextField(
      {super.key,
      this.icon,
      required this.hint,
      this.value,
      this.passType = false,
      required this.controller,
      required this.validator});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    if (widget.value != null) {
      widget.controller.text = widget.value ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.passType,
          enableSuggestions: !widget.passType,
          autocorrect: !widget.passType,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: widget.icon != null
                ? Icon(
                    widget.icon,
                    color: mainBackupColor,
                  )
                : null,
            hintText: widget.hint,
            hintStyle: const TextStyle(color: mainBackupColor),
          ),
        ),
      ),
    );
  }
}
