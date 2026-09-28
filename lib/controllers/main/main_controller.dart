import 'package:flutter/material.dart';
import 'package:flutter_test_gias/models/main/item_navbar_model.dart';
import 'package:flutter_test_gias/views/add_user/add_user_page.dart';
import 'package:flutter_test_gias/views/users/users_page.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget Function()> pageBuilders = [
    UsersPage.new,
    AddUserPage.new,
  ];
  List<ItemNavbarModel> items = [
    ItemNavbarModel(icon: Icons.group, title: 'Users'),
    ItemNavbarModel(icon: Icons.person_add, title: 'Add User'),
  ];
}
