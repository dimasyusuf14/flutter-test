import 'package:flutter/material.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';
import 'package:flutter_test_gias/widgets/shimmer/shimmer_widget.dart';

enum LeadingType { back, close }

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final List<Widget>? actions;
  final Color backgroundColor;
  final Color? foregroundColor;
  final bool centerTitle;
  final Widget? customText;
  final double? elevation;
  final IconData leadingIcon;
  final VoidCallback? onLeadingPressed;
  final bool withoutLeading;
  final double? customHeight;
  final bool withActionPadding;
  final TextStyle? titleStyle;
  final Color leadingIconColor;
  final Gradient? gradient;
  final Widget? backgroundImage;
  final bool isLoading;

  final String? avatarImageUrl;
  final AssetImage? avatarAssetImage;
  final VoidCallback? onAvatarTap;
  final double avatarRadius;
  final Color? avatarBackgroundColor;
  final Color? avatarIconColor;

  final Widget? logo;
  final IconData? logoIcon;
  final Color? logoBackgroundColor;
  final Color? logoIconColor;
  final double logoSize;

  const MainAppbar({
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
    this.leadingIconColor = kColorWhite,
    this.gradient,
    this.backgroundImage,
    this.isLoading = false,
    this.avatarImageUrl,
    this.avatarAssetImage,
    this.onAvatarTap,
    this.avatarRadius = 18,
    this.avatarBackgroundColor,
    this.avatarIconColor,
    this.logo,
    this.logoIcon,
    this.logoBackgroundColor,
    this.logoIconColor,
    this.logoSize = 28,
  });

  bool get _hasAvatar => avatarImageUrl != null || avatarAssetImage != null;

  bool get _hasLogo => logo != null || logoIcon != null;

  ImageProvider? get _avatarImageProvider {
    if (avatarImageUrl != null) {
      return NetworkImage(avatarImageUrl!);
    }
    if (avatarAssetImage != null) {
      return avatarAssetImage;
    }
    return null;
  }

  Widget _buildAvatar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: onAvatarTap,
        child: CircleAvatar(
          radius: 26,
          backgroundColor: avatarBackgroundColor ?? kColorWhite,
          backgroundImage: _avatarImageProvider,
          child: _avatarImageProvider == null
              ? Icon(
                  Icons.person,
                  color: avatarIconColor ?? kColorPrimary,
                  size: 28,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: logo != null
          ? Center(child: logo)
          : Icon(
              logoIcon,
              size: logoSize,
              color: logoIconColor ?? kColorTextDefault,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final resolvedActions = <Widget>[
      if (actions != null) ...actions!,
      if (_hasAvatar || onAvatarTap != null) _buildLogo(context),
    ];

    final titleContent =
        customText ??
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            isLoading
                ? const ShimmerWidget(width: 150, height: 24, radius: 4)
                : Text(
                    title ?? '',
                    overflow: TextOverflow.ellipsis,
                    style:
                        titleStyle ??
                        TStyle.poppins18SemiBold.copyWith(color: kColorPrimary),
                  ),
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              isLoading
                  ? const ShimmerWidget(width: 120, height: 20, radius: 4)
                  : Text(
                      subtitle!,
                      overflow: TextOverflow.ellipsis,
                      style: TStyle.poppins14SemiBold.copyWith(
                        color: kColorTextSubtitle,
                      ),
                    ),
            ],
          ],
        );

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kColorGray300, width: 1)),
      ),
      child: Stack(
        children: [
          AppBar(
            title: _hasLogo
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildAvatar(context),
                      Flexible(child: titleContent),
                    ],
                  )
                : titleContent,
            backgroundColor: backgroundImage != null
                ? Colors.transparent
                : (gradient != null ? Colors.transparent : backgroundColor),
            surfaceTintColor: backgroundImage != null
                ? Colors.transparent
                : (gradient != null ? Colors.transparent : backgroundColor),
            foregroundColor: foregroundColor,
            elevation: elevation,
            actions: resolvedActions,
            actionsPadding: withActionPadding
                ? const EdgeInsets.only(right: 4)
                : null,
            centerTitle: centerTitle,
            leadingWidth: withoutLeading ? 20 : 56,
            titleSpacing: 0,
            flexibleSpace: gradient != null && backgroundImage == null
                ? Container(decoration: BoxDecoration(gradient: gradient))
                : null,
            leading: withoutLeading
                ? const SizedBox.shrink()
                : IconButton(
                    icon: Icon(leadingIcon, color: leadingIconColor, size: 22),
                    onPressed:
                        onLeadingPressed ??
                        () {
                          Navigator.of(context).pop();
                        },
                    style: IconButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    tooltip: 'Back',
                  ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(customHeight ?? 8),
              child: const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (customHeight ?? 0) + 1);
}
