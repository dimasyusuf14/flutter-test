import 'package:flutter/material.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SmartRefresherHeader extends StatelessWidget {
  const SmartRefresherHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const WaterDropMaterialHeader(
      backgroundColor: kColorPrimary,
      color: kColorWhite,
    );
  }
}

class SmartRefresherFooter extends StatelessWidget {
  const SmartRefresherFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (_, status) {
        if (status == LoadStatus.loading) {
          return const SizedBox(
            height: 44,
            child: Center(
              child: SizedBox.square(
                dimension: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: kColorPrimary,
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
