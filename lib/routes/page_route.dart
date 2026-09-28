import 'package:flutter_test_gias/views/add_user/add_user_page.dart';
import 'package:flutter_test_gias/views/home/home_page.dart';
import 'package:flutter_test_gias/views/main/main_page.dart';
import 'package:flutter_test_gias/views/update_user/update_user_page.dart';
import 'package:get/get.dart';


import 'route_name.dart';

class PagesRoute {
  static final pages = [
    GetPage<void>(
      name: RouteName.mainPage,
      page: MainPage.new,
      transition: Transition.fade,
    ),
    GetPage<void>(
      name: RouteName.homePage,
      page: HomePage.new,
      transition: Transition.fade,
    ),
    GetPage<void>(
      name: RouteName.updateUserPage,
      page: UpdateUserPage.new,
      transition: Transition.fade,
    ),
    GetPage<void>(
      name: RouteName.addUserPage,
      page: AddUserPage.new,
      transition: Transition.fade,
    ),
  ];
}
