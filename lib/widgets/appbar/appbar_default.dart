import 'package:flutter/material.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';

enum LeadingType { back, close }

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final List<Widget>? actions;
  final Color backgroundColor;
  final Color? foregroundColor;
  final bool centerTitle;
  final Widget? customText;
  final double? elevation;
  final IconData leadingIcon;
  final void Function()? onLeadingPressed;
  final bool withoutLeading;
  final double? customHeight;
  final bool withActionPadding;
  final TextStyle? titleStyle;
  final Color leadingIconColor;
  final Gradient? gradient;
  final Widget? backgroundImage;

  const AppBarDefault({
    super.key,
    this.title,
    this.subtitle,
    this.actions,
    this.backgroundColor = Colors.transparent,
    this.foregroundColor,
    this.centerTitle = false,
    this.customText,
    this.elevation = .33,
    this.leadingIcon = Icons.arrow_back_ios_new,
    this.onLeadingPressed,
    this.withoutLeading = false,
    this.customHeight = 8,
    this.withActionPadding = true,
    this.titleStyle,
    this.leadingIconColor = kColorPrimary,
    this.gradient,
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: kColorGray300, width: 1)),
        ),
        child: Stack(
          children: [
            AppBar(
              title:
                  customText ??
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              titleStyle ??
                              TStyle.poppins20SemiBold.copyWith(
                                color: kColorPrimary,
                              ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TStyle.poppins14SemiBold.copyWith(
                            color: kColorTextSubtitle,
                          ),
                        ),
                    ],
                  ),
              backgroundColor: backgroundImage != null
                  ? Colors.transparent
                  : (gradient != null ? Colors.transparent : backgroundColor),
              surfaceTintColor: backgroundImage != null
                  ? Colors.transparent
                  : (gradient != null ? Colors.transparent : backgroundColor),
              foregroundColor: foregroundColor,
              elevation: elevation,
              actions: actions,
              actionsPadding: !withActionPadding
                  ? null
                  : const EdgeInsets.only(right: 4),
              centerTitle: centerTitle,
              leadingWidth: withoutLeading ? 20 : 56,
              titleSpacing: 0,
              flexibleSpace: gradient != null && backgroundImage == null
                  ? Container(decoration: BoxDecoration(gradient: gradient))
                  : null,
              leading: withoutLeading
                  ? const SizedBox.shrink()
                  : Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: Icon(
                            leadingIcon,
                            color: leadingIconColor,
                            size: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {
                            if (onLeadingPressed != null) {
                              onLeadingPressed!();
                            } else {
                              Navigator.of(context).maybePop();
                            }
                          },
                          style: IconButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.zero,
                          ),
                          tooltip: 'Back',
                        );
                      },
                    ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(customHeight ?? 8),
                child: const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (customHeight ?? 0) + 1, // +1 for the bottom border
  );
}
