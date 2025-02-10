//
//___________________________________________________________________
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
//___________________________________________________________________

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
//___________________________________________________________________

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
//___________________________________________________________________

String? validateFirstName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'First name is required';
  }

  final RegExp regex = RegExp(r"^[a-zA-ZÀ-ÖØ-öø-ÿ'-]{2,40}$");

  if (!regex.hasMatch(value)) {
    return 'First name can only contain letters, hyphens, and apostrophes (2-40 characters).';
  }

  return null; // Valid input
}
//___________________________________________________________________

String? validateLastName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Last name is required';
  }

  final RegExp regex = RegExp(r"^[a-zA-ZÀ-ÖØ-öø-ÿ'-]{2,40}$");

  if (!regex.hasMatch(value)) {
    return 'Last name can only contain letters, hyphens, and apostrophes (2-40 characters).';
  }

  return null; // Valid input
}
//___________________________________________________________________

String? validateNickname(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Nickname is required';
  }

  final RegExp regex = RegExp(r'^[a-zA-Z0-9._]{2,30}$');

  if (!regex.hasMatch(value)) {
    return 'Nickname can contain letters, numbers, underscores, and dots (2-30 characters).';
  }

  return null; // Valid input
}
//___________________________________________________________________

String? validateMobilnum(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Mobil number is required';
  }

  final RegExp regex = RegExp(r'^\+?[0-9]{10,15}$');

  if (!regex.hasMatch(value)) {
    return 'Enter a valid Mobil number (10-15 digits, optionally starting with +).';
  }

  return null; // Valid input
}
//___________________________________________________________________

