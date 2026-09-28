import 'package:flutter/material.dart';
import 'package:flutter_test_gias/models/main/item_navbar_model.dart';
import 'package:flutter_test_gias/views/add_user/add_user_page.dart';
import 'package:flutter_test_gias/views/home/home_page.dart';
import 'package:flutter_test_gias/views/update_user/update_user_page.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget Function()> pageBuilders = [
    HomePage.new,
    UpdateUserPage.new,
    AddUserPage.new,
  ];
  List<ItemNavbarModel> items = [
    ItemNavbarModel(icon: Icons.home_outlined, title: 'Home'),
    ItemNavbarModel(icon: Icons.history, title: 'History'),
    ItemNavbarModel(icon: Icons.person, title: 'Profile'),
  ];
}
