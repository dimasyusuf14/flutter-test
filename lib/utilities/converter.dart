import 'package:flutter/material.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';

Color colorFromHex(String? hex, {Color fallback = kColorBlue600}) {
  if (hex == null || hex.isEmpty) {
    return fallback;
  }
  var clean = hex.replaceAll('#', '').toUpperCase();
  if (clean.length == 6) {
    clean = 'FF$clean'; // ensure opacity
  }
  try {
    return Color(int.parse(clean, radix: 16));
  } catch (_) {
    return fallback;
  }
}
