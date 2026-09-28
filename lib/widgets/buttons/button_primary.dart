import 'package:flutter/material.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';

enum ButtonIconPosition { leading, trailing }

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
    this.borderRadius = 4,
    this.iconPosition = ButtonIconPosition.leading,
    this.textContainerPadding,
    this.textContainerDecoration,
    this.iconContainerPadding,
    this.iconContainerDecoration,
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
  final double borderRadius;
  final ButtonIconPosition iconPosition;
  final EdgeInsetsGeometry? textContainerPadding;
  final BoxDecoration? textContainerDecoration;
  final EdgeInsetsGeometry? iconContainerPadding;
  final BoxDecoration? iconContainerDecoration;

  @override
  Widget build(BuildContext context) {
    final isEnabled = isActive && !isLoading;
    return Container(
      decoration: BoxDecoration(
        color: isActive
            ? color
            : kColorGray200,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderWidth > 0 && borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: isEnabled ? onTap : () {},
          child: Container(
            padding: const EdgeInsets.all(4),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (isLoading) ...[
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(
                          isActive ? textcolor : kColorGray700,
                        ),
                      ),
                    ),
                    SizedBox(width: iconSpacing),
                  ] else if (icon != null &&
                      iconPosition == ButtonIconPosition.leading) ...[
                    Container(
                      padding: iconContainerPadding ?? const EdgeInsets.all(8),
                      decoration:
                          iconContainerDecoration ??
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            color: isActive
                                ? textcolor.withValues(alpha: 0.2)
                                : kColorGray700.withValues(alpha: 0.2),
                          ),
                      child: Icon(
                        icon,
                        color: isActive ? textcolor : kColorGray700,
                        size: iconSize,
                      ),
                    ),
                    SizedBox(width: iconSpacing),
                  ],

                  Flexible(
                    child: Container(
                      padding:
                          textContainerPadding ??
                          const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                      decoration:
                          textContainerDecoration ??
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            color: isActive
                                ? textcolor.withValues(alpha: 0.2)
                                : kColorGray700.withValues(alpha: 0.2),
                          ),
                      child: Text(
                        text,
                        style: TStyle.poppins16SemiBold.copyWith(
                          color: isActive
                              ? textcolor
                              : kColorGray600,
                          fontSize: fontSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  if (!isLoading &&
                      icon != null &&
                      iconPosition == ButtonIconPosition.trailing) ...[
                    SizedBox(width: iconSpacing),
                    Container(
                      padding:
                          iconContainerPadding ?? const EdgeInsets.all(12),
                      decoration:
                          iconContainerDecoration ??
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            color: isActive
                                ? textcolor.withValues(alpha: 0.2)
                                : kColorGray700.withValues(alpha: 0.2),
                          ),
                      child: Icon(
                        icon,
                        color: isActive ? textcolor : kColorGray700,
                        size: iconSize,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}