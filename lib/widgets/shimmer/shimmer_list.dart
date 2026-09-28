import 'package:flutter/material.dart';
import 'package:flutter_test_gias/widgets/shimmer/shimmer_widget.dart';
import 'package:get/get.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({
    super.key,
    required this.count,
    required this.heightCard,
    this.margin = const EdgeInsets.only(top: 8, left: 0, right: 0, bottom: 8),
  });
  final int count;
  final double heightCard;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: count,
      itemBuilder: (context, index) {
        return Container(
          margin: margin,
          child: ShimmerWidget(width: Get.width, height: heightCard, radius: 8),
        );
      },
    );
  }
}
