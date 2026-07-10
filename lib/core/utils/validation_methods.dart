bool isEmailValid(String inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;
  // ignore: unnecessary_null_comparison
  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString.isNotEmpty) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(pattern);
    isInputStringValid = regExp.hasMatch(inputString);
  }
  return isInputStringValid;
}

/*
Password Requirements:

Minimum Length: Your password must be at least 8 characters long.
Uppercase Letter: Your password must contain at least one uppercase letter (e.g., A, B, C).
Lowercase Letter: Your password must include at least one lowercase letter (e.g., a, b, c).
Digit: Your password must have at least one numeric digit (e.g., 1, 2, 3).
Special Character: Your password must include at least one special character (e.g., !, @, #, $).
No Spaces: Your password should not contain any spaces.
 */
bool isPasswordValid(String inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;
  // ignore: unnecessary_null_comparison
  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString.isNotEmpty) {
    const pattern =
        r'^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$';
    final regExp = RegExp(pattern);
    isInputStringValid = regExp.hasMatch(inputString);
  }
  return isInputStringValid;
}
