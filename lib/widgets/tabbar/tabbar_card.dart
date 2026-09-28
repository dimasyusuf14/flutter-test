import 'package:flutter/material.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';

class TabbarCard extends StatelessWidget {
  const TabbarCard({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
    required this.isFirstIndex,
  });

  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final bool isFirstIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive
                    ? kColorPrimary
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TStyle.poppins14SemiBold.copyWith(
              color: isActive
                  ? kColorPrimary
                  : kColorDarkTextSubtitle,
            ),
          ),
        ),
      ),
    );
  }
}
