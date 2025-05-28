class Validator {
  static bool hasMinLength(String? value, {int minLength = 2}) {
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
    return RegExp(r'^(049|043|0969)[0-9]{8}$').hasMatch(value);
  }

  final String text = 'bababab';

  static bool isWebsite(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    return RegExp(
      r"^(https?:\/\/)?(www\.)?[a-zA-Z0-9\-]+\.[a-zA-Z]{2,}([\/\w\-\.\?=&%]*)?$",
    ).hasMatch(value.trim());
  }
}
