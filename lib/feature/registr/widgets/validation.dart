String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  }
  // Check if the email is valid
  final emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (!emailRegExp.hasMatch(value)) {
    return 'Invalid email';
  }
  return null;
}

String? validateCityCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter a city code';
  }
  // Check if it contains only digits and is 5 characters long
  if (!RegExp(r'^[a-zA-Z0-9]{1,9}$').hasMatch(value)) {
    return 'Entered incorrectly ';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter a password';
  }
  // Check if it contains only digits and is 4 characters long
  if (!RegExp(r'^\d{4}$').hasMatch(value)) {
    return 'Password must contain exactly 4 digits';
  }
  return null;
}
