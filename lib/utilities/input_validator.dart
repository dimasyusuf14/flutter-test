class InputValidator {
  static String? confirmNewPassword(String value, String password) {
    final trimmedValue = value.trim();
    final trimmedPassword = password.trim();
    if (trimmedValue.isEmpty) {
      return 'New password confirmation is required';
    } else if (trimmedValue.length > 64) {
      return 'Password confirmation must be at most 64 characters';
    } else if (trimmedValue != trimmedPassword) {
      return 'Password confirmation does not match';
    }
    return null;
  }

  static String? email(String value) {
    final trimmedValue = value.trim();
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (trimmedValue.isEmpty) {
      return 'Email is required';
    } else if (trimmedValue.length > 255) {
      return 'Email must be at most 255 characters';
    } else if (!emailRegex.hasMatch(trimmedValue)) {
      return 'Email is invalid';
    }
    return null;
  }

  static String? emailNotRequired(String value) {
    final trimmedValue = value.trim();
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (trimmedValue.length > 255) {
      return 'Email must be at most 255 characters';
    } else if (trimmedValue.isNotEmpty && !emailRegex.hasMatch(trimmedValue)) {
      return 'Email is invalid';
    }
    return null;
  }

  static String? name(String value) {
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return 'Name is required';
    } else if (trimmedValue.length > 100) {
      return 'Name must be at most 100 characters';
    } else if (RegExp(r'[0-9]').hasMatch(trimmedValue)) {
      return 'Name cannot contain numbers';
    } else if (RegExp(
      r'[!@#<>?":_`~;[\]\\|=+)(*&^%$£¢€¥₩₹/.,]',
    ).hasMatch(trimmedValue)) {
      return 'Name cannot contain special characters';
    }
    return null;
  }

  static String? password(String value) {
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return 'Password is required';
    }
    if (trimmedValue.length < 8 || trimmedValue.length > 20) {
      return 'Your password must be 8-20 characters long.';
    }
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,20}$');
    if (!passwordRegex.hasMatch(trimmedValue)) {
      return 'Your password must contain letters and numbers, and must not contain spaces, special characters, or emoji.';
    }
    return null;
  }

  static String? createPassword(String value) {
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return 'Password is required';
    } else if (trimmedValue.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (trimmedValue.length > 64) {
      return 'Password must be at most 64 characters';
    }

    // Regex: At least 1 letter, 1 number, and 1 symbol
    final passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[^A-Za-z0-9]).+$',
    );
    if (!passwordRegex.hasMatch(trimmedValue)) {
      return 'Password must contain at least one letter and one number, and must not contain spaces, special characters, or emoji.';
    }

    return null;
  }

  static String? phoneNumber(String value) {
    final trimmedValue = value.trim();
    const minLength = 10;
    const maxLength = 15;

    if (trimmedValue.isEmpty) {
      return 'Phone number is required';
    } else if (trimmedValue.length < minLength ||
        trimmedValue.length > maxLength) {
      return 'Phone number must be between $minLength and $maxLength characters';
    } else if (!RegExp(r'^\d+$').hasMatch(trimmedValue)) {
      return 'Phone number can only contain digits';
    }
    return null;
  }

  static String? required(String title, String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  static String? minLength({
    required String value,
    required int min,
    String? message,
  }) {
    if (value.length < min) {
      return message ??
          // LocaleKeys.minLengthRequired.trParams({'min': min.toString()});
          'Minimum @min characters required.'.replaceAll(
            '@min',
            min.toString(),
          );
    }
    return null;
  }

  static String? maxLength({
    required String value,
    required int max,
    String? message,
  }) {
    if (value.length > max) {
      return message ??
          // LocaleKeys.maxLengthAllowed.trParams({'max': max.toString()});
          'Maximum @max characters allowed.'.replaceAll('@max', max.toString());
    }
    return null;
  }
}
