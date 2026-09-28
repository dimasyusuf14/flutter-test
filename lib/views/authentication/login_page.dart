import 'package:flutter/material.dart';
import 'package:flutter_test_gias/utilities/dimensions.dart';
import 'package:flutter_test_gias/utilities/input_validator.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';
import 'package:flutter_test_gias/widgets/buttons/button_action.dart';
import 'package:flutter_test_gias/widgets/buttons/button_primary.dart';
import 'package:flutter_test_gias/widgets/input/input_text.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorGray50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: kPagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.1),
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetConstant.imgLogoGias),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'HAeon Driver App',
                style: TStyle.poppins24SemiBold.copyWith(color: kColorPrimary),
              ),
              const SizedBox(height: 4),
              Text(
                'Login to your driver account',
                style: TStyle.poppins16Regular.copyWith(color: kColorGray600),
              ),
              const SizedBox(height: 32),
              InputText(
                // title: 'Email Address',
                hintText: 'Enter your email address',
                hintStyle: TStyle.poppins14Medium.copyWith(
                  color: kColorGray500,
                ),
                fillColor: kColorWhite,
                textStyle: TStyle.poppins14Medium.copyWith(
                  color: kColorTextDefault,
                ),
                borderRadius: 8,
                prefixIcon: Icon(Icons.email_outlined, color: kColorGray500),
                textInputType: TextInputType.emailAddress,
                validator: InputValidator.email,
              ),
              const SizedBox(height: 24),
              InputText(
                      // title: 'Password',
                      hintText: 'Enter your password',
                      hintStyle: TStyle.poppins14Medium.copyWith(
                        color: kColorGray500,
                      ),
                      textStyle: TStyle.poppins14Medium.copyWith(
                        color: kColorTextDefault,
                      ),
                      fillColor: kColorWhite,
                      borderRadius: 8,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: kColorGray500,
                      ),

                      textInputType: TextInputType.visiblePassword,
                      validator: InputValidator.password,
                      obscureText: true,
                    ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  ButtonAction(
                      onTap: () {},
                      padding: 4,
                      child: Text(
                        'Forgot Password?',
                        style: TStyle.poppins14SemiBold.copyWith(
                          color: kColorPrimary,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              ButtonPrimary(
                  text: 'LOGIN',
                  textcolor: kColorWhite,
                  fontSize: 16,
                  onTap: () {},
                  color: kColorPrimary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
