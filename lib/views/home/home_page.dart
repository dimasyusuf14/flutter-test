import 'package:flutter/material.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';
import 'package:flutter_test_gias/widgets/appbar/main_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorGray50,
      appBar: MainAppbar(
        title: 'GIAS',
        subtitle: 'Jhon Doe Hidayat',
        titleStyle: TStyle.poppins20SemiBold.copyWith(color: kColorTextDefault),
        withoutLeading: true,
        centerTitle: false,
        backgroundColor: kColorGray50,
        logo: Image.asset(AssetConstant.imgLogoGias, width: 70, height: 40),
        onAvatarTap: () {},
      ),
      body: Center(
        child: Text(
          'Home Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
