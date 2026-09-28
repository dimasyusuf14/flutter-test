import 'package:flutter/material.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final int status;

  String get label {
    switch (status) {
      case 8:
        return 'Completed';
      case 9:
        return 'Expired';
      case 10:
        return 'Cancelled';
      case 7:
        return 'Picked Up';
      case 6:
        return 'Arrived';
      case 5:
        return 'Confirmed';
      default:
        return 'Pending';
    }
  }

  Color get color {
    switch (status) {
      case 5:
        return kColorIndigo500;
      case 6:
        return kColorOrange500;
      case 7:
        return kColorAmber500;
      case 8:
        return kColorGreen600;
      case 9:
        return kColorGray500;
      case 10:
        return kColorRed500;
      default:
        return kColorAmber500;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TStyle.poppins11SemiBold.copyWith(color: kColorWhite),
          ),
        ],
      ),
    );
  }
}
