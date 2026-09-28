import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_gias/routes/page_route.dart';
import 'package:flutter_test_gias/services/api_services.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';
import 'package:flutter_test_gias/views/splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await GetStorage.init('settings');

  // Initialize Firebase
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseMessagingService.instance.init();
  // await LocationTrackingForegroundService.instance.initialize();

  Get.put(ApiServices());
  runApp(const ProdApp());
}

class ProdApp extends StatelessWidget {
  const ProdApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: kColorGray50,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return RefreshConfiguration(
      footerBuilder: () => const ClassicFooter(
        loadingIcon: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            color: kColorPrimary,
            strokeWidth: 2,
          ),
        ),
      ),
      headerBuilder: () => const WaterDropMaterialHeader(
        backgroundColor: kColorPrimary,
        distance: 40,
      ),
      child: GetMaterialApp(
        title: 'Flutter Test Gias',
        getPages: PagesRoute.pages,
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
    );
  }
}
