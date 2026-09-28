import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_test_gias/controllers/main/main_controller.dart';
import 'package:flutter_test_gias/views/main/widgets/item_navbar.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: SafeArea(
        top: false,
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: Container(
                    key: ValueKey(
                      mainController.selectedIndex.value,
                    ),
                    child: mainController
                        .pageBuilders[
                            mainController.selectedIndex.value
                        ](),
                  ),
                ),
              ),
            ),

            // Bottom Navigation
            Container(
              padding: EdgeInsets.only(
                bottom: Platform.isIOS ? 20 : 0,
              ),
              decoration: BoxDecoration(
                color: kColorWhite,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFC1C1C1).withValues(
                      alpha: 0.25,
                    ),
                    offset: const Offset(0, -1),
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Obx(
                () => Row(
                  children: List.generate(
                    mainController.items.length,
                    (index) {
                      return Expanded(
                        child: ItemNavbar(
                          model: mainController.items[index],
                          isActive:
                              mainController.selectedIndex.value ==
                                  index,
                          onTap: () {
                            mainController.selectedIndex.value =
                                index;
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}