import 'package:email_validator/email_validator.dart';

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please write a correct email";
  }
  if (!EmailValidator.validate(value)) {
    return "Please enter a valid email";
  }
  return null;
}

String? pseudoValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Choose a pseudo";
  }
  if (value.length < 2 || value.length > 16) {
    return "Your pseudo must have between 2 and 16 characters";
  }
  if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
    return "Your pseudo must contain only numbers and letters without spaces";
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Choose a password";
  }
  if (value.length < 8 || value.length > 16) {
    return "Your password must have between 8 and 16 characters";
  }
  if (!RegExp(r'\d').hasMatch(value)) {
    return "Your password must contain a number";
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return "Your password must contain a letter";
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return "Your password must contain a capital letter";
  }
  if (!RegExp(r'[-_=!;,?.:]').hasMatch(value)) {
    return "Your password must contain one of these characters: -_=!;,?.:";
  }
  return null;
}


String? birthdayValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "We need your birthday date";
  }

  DateTime? parsedDate = DateTime.tryParse(value);
  if (parsedDate == null) {
    return "Please send an ISO 8601 format date";
  }

  DateTime minAge = DateTime.now().subtract(Duration(days: 16 * 365));
  if (parsedDate.isAfter(minAge)) {
    return "Minimum age required is 16 years";
  }
  return null;
}
