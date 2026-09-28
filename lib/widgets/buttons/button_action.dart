import 'package:flutter/material.dart';

class ButtonAction extends StatelessWidget {
  const ButtonAction({
    super.key,
    required this.onTap,
    required this.child,
    this.padding = 8.0,
    this.backgroundColor,
    this.borderRadius,
    this.splashColor,
    this.highlightColor,
    this.border,
    this.width,
    this.height,
    this.margin,
    this.elevation = 0,
    this.shadowColor,
  });

  final VoidCallback onTap;
  final Widget child;
  final double padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Color? splashColor;
  final Color? highlightColor;
  final BoxBorder? border;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final double elevation;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadius ?? BorderRadius.circular(4),
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: shadowColor ?? Colors.black26,
                  blurRadius: elevation,
                  offset: Offset(0, elevation / 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(4),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(4),
          splashColor: splashColor,
          highlightColor: highlightColor,
          child: Padding(padding: EdgeInsets.all(padding), child: child),
        ),
      ),
    );
  }
}
