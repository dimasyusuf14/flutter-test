import 'package:flutter/material.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';
import 'package:flutter_test_gias/widgets/buttons/button_primary.dart';
import 'package:get/get.dart';

class ConfirmationBottomSheet {
  static Future<bool?> show({
    required String title,
    String message = '',
    Widget? messageWidget,
    String? confirmText,
    String? cancelText,
    Color? confirmColor,
    Color? cancelColor,
    IconData? icon,
    Color? iconColor,
    bool isDangerous = false,
    bool showCancelButton = true,
    double borderRadius = 20,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    return Get.bottomSheet<bool>(
      _BottomSheetContent(
        title: title,
        message: message,
        messageWidget: messageWidget,
        confirmText: confirmText ?? 'Confirm',
        cancelText: cancelText ?? 'Cancel',
        confirmColor: confirmColor,
        cancelColor: cancelColor,
        icon: icon,
        iconColor: iconColor,
        isDangerous: isDangerous,
        showCancelButton: showCancelButton,
        borderRadius: borderRadius,
        crossAxisAlignment: crossAxisAlignment,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}

class _BottomSheetContent extends StatelessWidget {
  final String title;
  final String message;
  final Widget? messageWidget;
  final String confirmText;
  final String cancelText;
  final Color? confirmColor;
  final Color? cancelColor;
  final IconData? icon;
  final Color? iconColor;
  final bool isDangerous;
  final bool showCancelButton;
  final double borderRadius;
  final CrossAxisAlignment crossAxisAlignment;

  const _BottomSheetContent({
    required this.title,
    required this.message,
    this.messageWidget,
    required this.confirmText,
    required this.cancelText,
    this.confirmColor,
    this.cancelColor,
    this.icon,
    this.iconColor,
    this.isDangerous = false,
    this.showCancelButton = true,
    this.borderRadius = 20,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final defaultConfirmColor = isDangerous ? kColorRed500 : kColorPrimary;

    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        16,
        24,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: kColorGray200,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Icon
          if (icon != null) ...[
            Center(
              child: Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  color: (iconColor ?? defaultConfirmColor).withValues(
                    alpha: .1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 45,
                  color: iconColor ?? defaultConfirmColor,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],

          // Title
          if (title.isNotEmpty) ...[
            Center(
              child: Text(
                title,
                style: TStyle.poppins18SemiBold.copyWith(
                  color: kColorGray900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
          ],

          // Message
          Center(
            child:
                messageWidget ??
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TStyle.poppins15Regular.copyWith(
                    color: kColorGray500,
                  ),
                ),
          ),

          const SizedBox(height: 28),

          // Buttons
          ButtonPrimary(
            onTap: () => Get.back(result: true),
            borderRadius: 8,
            text: confirmText,
            textContainerDecoration: const BoxDecoration(),
          ),
          if (showCancelButton) ...[
            const SizedBox(height: 12),
            ButtonPrimary(
              onTap: () => Get.back(result: false),
              borderRadius: 8,
              text: cancelText,
              borderColor: kColorGray200,
              borderWidth: 1.5,
              color: kColorGray300,
              textcolor: kColorGray600,
              textContainerDecoration: const BoxDecoration(),
            ),
          ],
        ],
      ),
    );
  }
}
