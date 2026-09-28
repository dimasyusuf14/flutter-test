part of 'utilities.dart';

InputDecoration kDefaultDecoration = InputDecoration(
  labelStyle: TStyle.poppins12Medium.copyWith(color: kColorGray700),
  filled: true,
  fillColor: kColorGray100,
  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFFC5CCD6), width: 1),
    borderRadius: BorderRadius.circular(8),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFFC5CCD6), width: 1),
    borderRadius: BorderRadius.circular(8),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFFC5CCD6), width: 1),
    borderRadius: BorderRadius.circular(8),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: kColorRed500),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: kColorRed500, width: 2),
  ),
  hintStyle: TStyle.poppins14Regular.copyWith(color: kColorGray700),
);
