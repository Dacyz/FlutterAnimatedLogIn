mixin UserValidation {
  bool isEmail(String? value) =>
      value!.isEmpty ||
      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);

  bool isDNI(String? value) =>
      value!.isEmpty || !RegExp(r"^\d{8}(?:[-\s]\d{4})?$").hasMatch(value);

  bool isName(String? value) =>
      value!.isEmpty ||
      !RegExp(r"([A-ZÀ-ÚÄ-Ü]){3,}").hasMatch(value.toUpperCase());
}
