import 'package:flutter/material.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';
enum SnackBarType {
  info,
  success,
  warning,
  error,
  networkError,
  locationDisabled;

  IconData get icon {
    switch (this) {
      case SnackBarType.info:
        return Icons.info_outline;
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.warning:
        return Icons.warning_amber_rounded;
      case SnackBarType.error:
        return Icons.error_outline;
      case SnackBarType.networkError:
        return Icons.wifi_off;
      case SnackBarType.locationDisabled:
        return Icons.location_off;
    }
  }

  Color get color {
    switch (this) {
      case SnackBarType.info:
        return kColorCyan500;
      case SnackBarType.success:
        return kColorGreen400;
      case SnackBarType.warning:
        return kColorAmber500;
      case SnackBarType.error:
        return kColorRed500;
      case SnackBarType.networkError:
        return kColorIndigo600;
      case SnackBarType.locationDisabled:
        return kColorGray400;
    }
  }
}
