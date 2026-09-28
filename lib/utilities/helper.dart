import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_test_gias/utilities/enum/snackbar_status.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

class Helper {
  static String? _cachedAppVersion;

  static void loadingScreen({String? message}) {
    Get
      ..closeAllSnackbars()
      ..dialog<void>(
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kColorWhite,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SpinKitFadingCircle(color: kColorGray700, size: 32),
                      const SizedBox(height: 8),
                      Text(
                        message ?? 'Loading...',
                        style: TStyle.poppins14Medium.copyWith(
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        useSafeArea: false,
        barrierDismissible: false,
        barrierColor: Colors.black.withValues(alpha: 0.2),
      );
  }

  static Future<String> getAppVersion() async {
    if (_cachedAppVersion != null) {
      return _cachedAppVersion!;
    }

    try {
      final info = await PackageInfo.fromPlatform();
      final version = info.version;
      final buildNumber = info.buildNumber;

      _cachedAppVersion = buildNumber.isNotEmpty
          ? '$version+$buildNumber'
          : version;
      return _cachedAppVersion!;
    } catch (_) {
      return '';
    }
  }

  static void setSnackBar({
    required SnackBarType type,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    Get
      ..closeCurrentSnackbar()
      ..snackbar(
        '',
        '',
        duration: duration,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: type.color,
        borderRadius: 8,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 8),
        messageText: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(type.icon, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: TStyle.poppins14Medium.copyWith(color: Colors.white),
              ),
            ),
            InkWell(
              onTap: Get.closeCurrentSnackbar,
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ],
        ),
        titleText: const SizedBox.shrink(),
        barBlur: 0,
        overlayBlur: 0,
      );
  }

  static Future<String?> pickDate(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String dateFormat = 'yyyy-MM-dd',
  }) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kColorGray700,
              onPrimary: kColorWhite,
              surface: kColorGray50,
              onSurface: kColorGray900,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: kColorGray700),
            ),
            dialogTheme: const DialogThemeData(backgroundColor: kColorGray50),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      return DateFormat(dateFormat).format(pickedDate);
    }
    return null;
  }

  static String formatDate(DateTime dt) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }

  static String formatTimeAgoShort(DateTime date) {
    final locale = Get.locale?.languageCode ?? 'en';
    final formatted = timeago.format(date, locale: locale);

    if (locale == 'en') {
      return formatted
          .replaceFirst('about an hour ago', 'an hour ago')
          .replaceFirst('minutes', 'mins')
          .replaceFirst('minute', 'min');
    } else if (locale == 'id') {
      return formatted
          .replaceFirst('sekitar ', '')
          .replaceFirst('kurang dari semenit yang lalu', 'baru saja');
    }
    return formatted;
  }

  static List<String> extractTags(String text) {
    final reg = RegExp(r'#[\w-]+');
    return reg.allMatches(text).map((m) => m.group(0)!).toSet().toList();
  }

  static String removeTagsFromText(String text) {
    final tagSeparator = RegExp(r'#[\w-]+(?:\s*[,;:])?');
    final leftOverSeparator = RegExp(r'\s{2,}');
    final danglingSeparator = RegExp(r'\s*[,;:]\s*$');

    var cleaned = text.replaceAll(tagSeparator, '');
    cleaned = cleaned.replaceAll(leftOverSeparator, ' ');
    cleaned = cleaned.replaceAll(danglingSeparator, '');
    return cleaned.trim();
  }

  static String? sanitizeBlobUri(String? raw) {
    if (raw == null) {
      return null;
    }
    var s = raw.trim();
    s = s.replaceAll('`', '');
    s = s.replaceAll(RegExp(r'^\"+|\"+$'), '');
    s = s.replaceAll(RegExp(r',+$'), '');
    s = s.replaceAll('%22', '');
    return s;
  }
}
