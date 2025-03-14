mixin LoginMixin {
  String? validatePassword(value) {
    value = value ?? "";
    value ??= "";
    value = value.replaceAll(" ", "");
    if (value.length < 8) {
      return "Contraseña no válida";
    }

    return null;
  }

  String? validateEmail(String? value) {
    value ??= "";
    value = value.replaceAll(" ", "");
    final bool isValid = RegExp(
      r"^[a-zA-Z0-9._%±]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$",
    ).hasMatch(value);
    return isValid ? null : "Email no válido";
  }
}
