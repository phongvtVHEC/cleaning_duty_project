class ValidateUtil {
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
      caseSensitive: false,
    );
    return emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    final passwordRegex = RegExp(r'^[a-zA-Z0-9]{8,50}$');
    return passwordRegex.hasMatch(password);
  }

  static void cleanErrorText(String text) {
    if (text.isNotEmpty) {
      text = "";
    }
  }

  static void cleanErrorDate(bool flagCheck) {
    if (flagCheck == true) {
      flagCheck = false;
    }
  }
}
