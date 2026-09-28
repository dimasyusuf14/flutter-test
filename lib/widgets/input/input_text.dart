import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';

class InputText extends StatefulWidget {
  final String title;
  final String? label;
  final String? hintText;
  final String? initialValue;
  final bool obscureText;
  final TextEditingController? controller;
  final ValueSetter<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatter;
  final String? Function(String)? validator;
  final int? maxLength;
  final TextInputType? textInputType;
  final bool disable;
  final void Function()? onTap;
  final bool readOnly;
  final Color? fillColor;
  final bool isRequired;
  final int? maxLines;
  final Widget? prefixIcon;
  final IconData? withIcon;
  final void Function()? onPressedIcon;
  final ValueSetter<String>? onChange;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Widget? customClearButton;
  final double? maxWidthPrefxIcon;
  final double? maxWidthSuffixIcon;
  final FocusNode? focusNode;
  final double? height;
  final TextInputAction? textInputAction;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final VoidCallback? onClear;

  final bool showClearButton;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final bool hasError;
  final double borderRadius;

  const InputText({
    super.key,
    this.title = '',
    this.label,
    this.hintText,
    this.initialValue,
    this.obscureText = false,
    this.controller,
    this.onTap,
    this.validator,
    this.onFieldSubmitted,
    this.maxLength,
    this.maxLines = 1,
    this.textInputType,
    this.disable = false,
    this.readOnly = false,
    this.fillColor = Colors.transparent,
    this.isRequired = false,
    this.prefixIcon,
    this.onChange,
    this.withIcon,
    this.onPressedIcon,
    this.prefixWidget,
    this.inputFormatter,
    this.suffixWidget,
    this.customClearButton,
    this.maxWidthPrefxIcon,
    this.maxWidthSuffixIcon,
    this.focusNode,
    this.height,
    this.textInputAction,
    this.textStyle,
    this.hintStyle,
    this.showClearButton = false,
    this.contentPadding,
    this.border,
    this.focusedBorder,
    this.hasError = false,
    this.onClear,
    this.borderRadius = 4,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late FocusNode _focusNode;
  late TextEditingController _textController;
  late bool _isObscure;
  late bool _hasText;
  late bool _isFocused;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _textController = widget.controller ?? TextEditingController();
    _isObscure = widget.obscureText;
    _hasText = _textController.text.isNotEmpty;
    _isFocused = false;

    _focusNode.addListener(_handleFocusChange);
    _textController.addListener(_handleTextChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleTextChange() {
    if (widget.showClearButton) {
      setState(() {
        _hasText = _textController.text.isNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _textController.removeListener(_handleTextChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    if (widget.controller == null) {
      _textController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMultiline = (widget.maxLines ?? 1) > 1;

    final double estimatedFieldHeight =
        widget.height ?? (28 + (((widget.maxLines ?? 1) - 1) * 20) + 20.0);

    return TapRegion(
      onTapOutside: (_) => _focusNode.unfocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.title,
                      style: TStyle.poppins14Medium.copyWith(
                        color: kColorTextDefault,
                      ),
                    ),
                    if (widget.isRequired) ...[
                      const SizedBox(width: 3),
                      const Text(
                        '*',
                        style: TextStyle(
                          fontSize: 13,
                          height: 17.5 / 13,
                          color: kColorRed500,
                        ),
                      ),
                    ],
                  ],
                ),
                if (widget.withIcon != null)
                  IconButton(
                    onPressed: widget.onPressedIcon,
                    icon: Icon(
                      widget.withIcon!,
                      color: kColorGray100,
                      size: 18,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
          ],
          if (widget.title.isNotEmpty && widget.withIcon == null)
            const SizedBox(height: 5),
          SizedBox(
            height: widget.height,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              child: Row(
                children: [
                  if (widget.prefixWidget != null) ...[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _isFocused ? kColorPrimary : kColorGray200,
                        ),
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius,
                        ),
                        color: widget.fillColor ?? Colors.transparent,
                      ),
                      child: widget.prefixWidget,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Expanded(
                    child: TextFormField(
                      enabled: !widget.disable,
                      focusNode: _focusNode,
                      obscureText: _isObscure,
                      maxLength: widget.maxLength,
                      maxLines: widget.maxLines,
                      controller: _textController,
                      keyboardType: widget.textInputType,
                      onTap: widget.onTap,
                      readOnly: widget.readOnly,
                      cursorColor: kColorPrimary,
                      style:
                          widget.textStyle ??
                          TStyle.poppins14Regular.copyWith(
                            color: kColorGray900,
                            fontWeight: FontWeight.w500,
                          ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => widget.validator != null
                          ? widget.validator!(value ?? '')
                          : null,
                      inputFormatters: widget.inputFormatter,
                      onChanged: widget.onChange,
                      textInputAction: widget.textInputAction,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        labelText: widget.label,
                        floatingLabelStyle: TStyle.poppins14Medium.copyWith(
                          color: widget.hasError ? kColorRed500 : kColorPrimary,
                        ),
                        labelStyle: TStyle.poppins14Medium.copyWith(
                          color: kColorGray700,
                        ),
                        filled: true,
                        fillColor: widget.fillColor ?? Colors.transparent,
                        prefixIcon: widget.prefixIcon == null
                            ? null
                            : isMultiline
                            ? Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 11),
                                  child: widget.prefixIcon,
                                ),
                              )
                            : widget.prefixIcon,
                        prefixIconConstraints: BoxConstraints(
                          minWidth: widget.maxWidthPrefxIcon ?? 40,
                          maxWidth: widget.maxWidthPrefxIcon ?? 40,
                          minHeight: isMultiline ? estimatedFieldHeight : 0,
                        ),
                        alignLabelWithHint: true,
                        suffixIconConstraints: BoxConstraints(
                          minWidth: widget.maxWidthSuffixIcon ?? 40,
                          maxWidth: widget.maxWidthSuffixIcon ?? 40,
                        ),
                        hintText: widget.hintText,
                        hintStyle:
                            widget.hintStyle ??
                            TStyle.poppins14Regular.copyWith(
                              color: kColorGray500,
                              fontWeight: FontWeight.w400,
                            ),
                        border:
                            widget.border ??
                            OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                widget.borderRadius,
                              ),
                              borderSide: BorderSide(
                                color: widget.hasError
                                    ? kColorRed500
                                    : kColorGray200,
                              ),
                            ),
                        enabledBorder:
                            widget.border ??
                            OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                widget.borderRadius,
                              ),
                              borderSide: BorderSide(
                                color: widget.hasError
                                    ? kColorRed500
                                    : kColorGray200,
                              ),
                            ),
                        focusedBorder:
                            widget.focusedBorder ??
                            OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                widget.borderRadius,
                              ),
                              borderSide: BorderSide(
                                color: widget.hasError
                                    ? kColorRed500
                                    : kColorPrimary,
                              ),
                            ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                          borderSide: const BorderSide(color: kColorRed500),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                          borderSide: const BorderSide(color: kColorRed500),
                        ),
                        disabledBorder:
                            widget.border ??
                            OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                widget.borderRadius,
                              ),
                              borderSide: BorderSide(
                                color: widget.hasError
                                    ? kColorRed500
                                    : kColorGray200,
                              ),
                            ),
                        errorStyle: TStyle.poppins12Regular.copyWith(
                          color: kColorRed500,
                        ),
                        errorMaxLines: 3,
                        suffixIcon: widget.obscureText
                            ? IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: kColorGray500,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              )
                            : widget.showClearButton && _hasText
                            ? IconButton(
                                icon:
                                    widget.customClearButton ??
                                    const Icon(
                                      Icons.close,
                                      color: kColorGray500,
                                      size: 20,
                                    ),
                                onPressed: () {
                                  _textController.clear();
                                  setState(() {
                                    _hasText = false;
                                  });
                                  widget.onClear?.call();
                                },
                              )
                            : widget.suffixWidget,
                      ),
                      onFieldSubmitted: widget.onFieldSubmitted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
