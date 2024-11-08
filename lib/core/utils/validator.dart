class Validator {
  static bool hasMinLength(String? value, {int minLength = 1}) {
    if (value == null) return false;
    return value.trim().length >= minLength;
  }

  static bool isEmail(String? value) {
    if (value == null) return false;
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(value);
  }

  static bool isPassword(String? value) {
    if (value == null) return false;
    return value.trim().length >= 6;
  }

  static bool isEGPhoneNumber(String? value) {
    if (value == null) return false;
    return RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(value);
  }
}
