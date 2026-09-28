import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test_gias/routes/route_name.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // ignore: prefer_single_quotes
  var version = "";

  @override
  void initState() {
    super.initState();
    checkVersion();
    splashscreenStart();
  }

  Future<void> checkVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    var platformDevice = '';

    if (Platform.isAndroid) {
      platformDevice = 'Android';
    }
    if (Platform.isIOS) {
      platformDevice = 'iOS';
    }

    logPrint('Platform: $platformDevice');

    setState(() {
      version = packageInfo.version;
    });
  }

  Future<void> splashscreenStart() async {
    const duration = Duration(seconds: 3);
    // final box = GetStorage();

    Timer(duration, () async {
      // final token = box.read<String>('token');
      // final emailAddress = box.read<String>('emailAddress');

      // if (token == null || emailAddress == null) {
      //   await Get.offAllNamed<void>(RouteName.loginPage);
      //   return;
      // }

      await Get.offAllNamed<void>(RouteName.mainPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        backgroundColor: kColorWhite,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetConstant.imgLogoGias,
                      width: MediaQuery.of(context).size.width * 0.45,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 48,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'App ver. $version',
                    textAlign: TextAlign.center,
                    style: TStyle.poppins10Regular.copyWith(
                      color: kColorTextSubtitle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
