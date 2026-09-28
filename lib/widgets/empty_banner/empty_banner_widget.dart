import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';
import 'package:get/get.dart';

class EmptyBanner extends StatelessWidget {
  const EmptyBanner({
    super.key,
    required this.description,
    required this.height,
    this.icon = AssetConstant.imgLogoGias,
  });

  final String description;
  final double height;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: Get.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: kColorGray200,
        ),
        boxShadow: [
          BoxShadow(
            color: kColorShadow,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 75,
            height: 75,
            colorFilter: ColorFilter.mode(
              kColorGray400,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Oops!',
            style: TStyle.poppins16Bold.copyWith(
              color: kColorGray400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TStyle.poppins14Regular.copyWith(
              color: kColorGray400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
