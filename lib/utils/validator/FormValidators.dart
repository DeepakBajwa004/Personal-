// form_validators.dart

class FormValidators {
  /// Validates if the input is empty
  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  /// Validates if the input is a valid email address
  static String? validateEmail(String? value) {
    const String emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    final RegExp emailRegex = RegExp(emailPattern);

    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates if the password meets the minimum length requirement
  static String? validatePassword(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    return null;
  }

  /// Validates if the name contains only letters and spaces
  static String? validateName(String? value) {
    // Example validation logic
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    } else if (value.length < 3) {
      return 'Username must be at least 3 characters long';
    }
    return null; // Return null if validation is successful
  }

  /// Validates if the phone number is valid
  static String? validatePhoneNumber(String? value) {
    const String phonePattern = r'^\+?[1-9]\d{1,14}$'; // E.164 format
    final RegExp phoneRegex = RegExp(phonePattern);

    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  /// Validates if the OTP is valid (usually 4-6 digit code)
  static String? validateOtp(String? value, {int length = 6}) {
    if (value == null || value.isEmpty) {
      return 'Please enter the OTP';
    } else if (value.length != length) {
      return 'OTP must be exactly $length digits';
    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'OTP can contain only digits';
    }
    return null;
  }


}
