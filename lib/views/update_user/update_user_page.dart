import 'package:flutter/material.dart';
import 'package:flutter_test_gias/controllers/user/user_controller.dart';
import 'package:flutter_test_gias/utilities/dimensions.dart';
import 'package:flutter_test_gias/utilities/enum/data_load.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';
import 'package:flutter_test_gias/widgets/appbar/appbar_default.dart';
import 'package:flutter_test_gias/widgets/buttons/button_primary.dart';
import 'package:flutter_test_gias/widgets/input/input_text.dart';
import 'package:get/get.dart';

class UpdateUserPage extends StatelessWidget {
  UpdateUserPage({super.key});

  final UserController controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorGray50,
      appBar: AppBarDefault(
        title: 'Update User Page',
        withoutLeading: false,
        centerTitle: false,
        onLeadingPressed: () {
          Get.back<void>();
        },
      ),
      body: Obx(() {
        return Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            padding: kPagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputText(
                  title: 'Full Name',
                  prefixIcon: Icon(Icons.person, color: kColorGray400),
                  hintText: 'Enter your full name',
                  fillColor: kColorWhite,
                  controller: controller.fullNameController.value,
                ),
                const SizedBox(height: 16),
                InputText(
                  title: 'Email',
                  prefixIcon: Icon(Icons.email, color: kColorGray400),
                  hintText: 'Enter your email',
                  fillColor: kColorWhite,
                  controller: controller.emailController.value,
                ),
                const SizedBox(height: 16),
                InputText(
                  title: 'Company',
                  prefixIcon: Icon(Icons.business, color: kColorGray400),
                  hintText: 'Enter your company',
                  fillColor: kColorWhite,
                  controller: controller.companyController.value,
                ),
                const SizedBox(height: 24),
                ButtonPrimary(
                  onTap: () {
                    if (controller.formKey.currentState?.validate() ?? false) {
                      controller.updateUser();
                    }
                  },
                  text: 'Update User',
                  isLoading: controller.isLoading.value == DataLoad.loading,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
