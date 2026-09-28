import 'package:flutter/material.dart';
import 'package:flutter_test_gias/models/main/item_navbar_model.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';
import 'package:get/get.dart';

class ItemNavbar extends StatelessWidget {
  const ItemNavbar({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.model,
  });

  final VoidCallback onTap;
  final bool isActive;
  final ItemNavbarModel model;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : Get.width / 4;

        final horizontalPadding = itemWidth < 80
            ? (isActive ? 6.0 : 2.0)
            : (isActive ? 14.0 : 6.0);

        return GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: itemWidth < 80 ? 4 : 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: isActive ? itemWidth * 0.5 : 0,
                  height: 3,
                  decoration: BoxDecoration(
                    color: kColorPrimary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 6),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? kColorPrimary : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        model.icon,
                        size: itemWidth < 80 ? 20 : 24,
                        color: isActive ? kColorWhite : kColorGray500,
                      ),
                      const SizedBox(height: 2),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          model.title,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.visible,
                          style: TStyle.poppins12Medium.copyWith(
                            color: isActive ? kColorWhite : kColorGray500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
