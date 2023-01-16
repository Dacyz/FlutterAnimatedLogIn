mixin UserValidation {
  /// Clase para validación de datos
  ///
  /// Uses cases:
  /// - Validar correo electronico.
  /// - Validar DNI.
  /// - Validar nombre.
  /// - Validar contraseña.
  ///

  bool isEmail(String? value) =>
      value!.isEmpty ||
      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);

  bool isDNI(String? value) =>
      value!.isEmpty || !RegExp(r"^\d{8}(?:[-\s]\d{4})?$").hasMatch(value);

  bool isName(String? value) =>
      value!.isEmpty || !RegExp(r"^[A-Z]+.{3,}$").hasMatch(value.toUpperCase());

  bool isPassword(String? value) =>
      value!.isEmpty ||
      !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value);
}
