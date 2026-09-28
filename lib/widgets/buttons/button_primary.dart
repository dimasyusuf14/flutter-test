import 'package:flutter/material.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    super.key,
    required this.onTap,
    required this.text,
    this.color = kColorPrimary,
    this.textcolor = kColorWhite,
    this.isActive = true,
    this.isLoading = false,
    this.icon,
    this.iconSize = 20,
    this.iconSpacing = 8,
    this.fontSize = 14,
    this.borderColor,
    this.borderWidth = 0,
  });

  final VoidCallback onTap;
  final String text;
  final Color color;
  final Color textcolor;
  final bool isActive;
  final bool isLoading;
  final IconData? icon;
  final double iconSize;
  final double iconSpacing;
  final double fontSize;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final isEnabled = isActive && !isLoading;
    return Container(
      decoration: BoxDecoration(
        color: isActive ? color : kColorGray50,
        borderRadius: BorderRadius.circular(4),
        border: borderWidth > 0 && borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: isEnabled ? onTap : () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(
                          isActive ? textcolor : kColorGray700,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          SizedBox(width: iconSpacing),
                          Icon(
                            icon,
                            color: isActive ? textcolor : kColorGray700,
                            size: iconSize,
                          ),
                        ],
                        const SizedBox(width: 4),
                        Text(
                          text,
                          style: TStyle.poppins16SemiBold.copyWith(
                            color: isActive ? textcolor : kColorGray700,
                            fontSize: fontSize,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
