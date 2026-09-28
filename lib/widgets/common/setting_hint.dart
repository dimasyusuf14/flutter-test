import 'package:flutter/material.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';

class SettingHint extends StatelessWidget {
  const SettingHint({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kColorPrimary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: kColorPrimary.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        text,
        style: TStyle.poppins13Medium.copyWith(
          color: kColorGray700,
        ),
      ),
    );
  }
}
