import 'package:flutter/material.dart';
import 'package:flutter_test_gias/models/user/user_detail_model.dart';
import 'package:flutter_test_gias/models/user/user_model.dart';
import 'package:flutter_test_gias/services/api_services.dart';
import 'package:flutter_test_gias/utilities/api_constant.dart';
import 'package:flutter_test_gias/utilities/enum/data_load.dart';
import 'package:flutter_test_gias/utilities/enum/snackbar_status.dart';
import 'package:flutter_test_gias/utilities/helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserController extends GetxController {
  final isLoading = DataLoad.loading.obs;
  final isLoadingDetail = false.obs;
  final users = <UserModel>[].obs;
  final userDetail = Rxn<UserDetailModel>();
  final selectedUser = Rxn<UserDetailModel>();
  final refreshController = RefreshController();
  final enablePullUp = true.obs;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController().obs;
  final fullNameController = TextEditingController().obs;
  final companyController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  @override
  void onClose() {
    refreshController.dispose();
    emailController.value.dispose();
    fullNameController.value.dispose();
    companyController.value.dispose();
    super.onClose();
  }

  void clearForm() {
    selectedUser.value = null;
    fullNameController.value.clear();
    emailController.value.clear();
    companyController.value.clear();
  }

  Future<void> fetchUsers() async {
    debugPrint("Users fetchUsers ${DateTime.now()}");
    try {
      isLoading.value = DataLoad.loading;

      final rawLocalUsers =
          GetStorage().read<List<dynamic>>('local_users') ?? [];
      final localUserModels = rawLocalUsers
          .map((e) => UserModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();

      final data = await ApiServices.api(
        endPoint: APIEndpoint.users,
        type: APIMethod.get,
        param: '?per_page=20',
        withToken: false,
      );

      if (data.success && data.data != null) {
        final list = data.data as List<dynamic>;
        final apiUsers = list.map((e) {
          final json = e as Map<String, dynamic>;
          final login = json['login'] as String;
          final localUser = GetStorage().read<Map<String, dynamic>>(
            'updatedUser:$login',
          );
          return UserModel.fromJson({...json, ...?localUser});
        }).toList();

        users.assignAll([...localUserModels, ...apiUsers]);
      } else {
        users.assignAll(localUserModels);
        Helper.setSnackBar(
          message: _errorMessage(data.statusCode, data.message, 'load users'),
          type: SnackBarType.error,
        );
      }
    } catch (e) {
      Helper.setSnackBar(
        message: 'Something went wrong. Please try again.',
        type: SnackBarType.error,
      );
    } finally {
      isLoading.value = DataLoad.done;
    }
  }

  Future<void> fetchUserDetail(String login) async {
    try {
      isLoadingDetail.value = true;

      final rawLocalUsers =
          GetStorage().read<List<dynamic>>('local_users') ?? [];
      final localMatch = rawLocalUsers.firstWhereOrNull(
        (e) => (e as Map)['login'] == login,
      );

      if (localMatch != null) {
        _setUserDetail(
          UserDetailModel.fromJson(
            Map<String, dynamic>.from(localMatch as Map),
          ),
        );
        return;
      }

      final localUser = GetStorage().read<Map<String, dynamic>>(
        'updatedUser:$login',
      );
      if (localUser != null) {
        _setUserDetail(UserDetailModel.fromJson(localUser));
        return;
      }

      final data = await ApiServices.api(
        endPoint: APIEndpoint.users,
        type: APIMethod.get,
        param: '/$login',
        withToken: false,
      );

      if (data.success && data.data != null) {
        final detail = UserDetailModel.fromJson(
          data.data as Map<String, dynamic>,
        );

        _setUserDetail(detail);
      } else {
        Helper.setSnackBar(
          message: _errorMessage(
            data.statusCode,
            data.message,
            'load user detail',
          ),
          type: SnackBarType.error,
        );
      }
    } catch (e) {
      Helper.setSnackBar(
        message: 'Something went wrong. Please try again.',
        type: SnackBarType.error,
      );
    } finally {
      isLoadingDetail.value = false;
    }
  }

  Future<void> updateUser() async {
    final user = selectedUser.value;
    if (user == null) return;

    final email = emailController.value.text.trim();
    final fullName = fullNameController.value.text.trim();
    final company = companyController.value.text.trim();

    try {
      isLoading.value = DataLoad.loading;
      await Future<void>.delayed(const Duration(milliseconds: 300));

      final updatedUser = user.copyWith(
        name: fullName,
        email: email,
        company: company,
      );
      selectedUser.value = updatedUser;
      final userIndex = users.indexWhere((item) => item.login == user.login);
      if (userIndex != -1) {
        final listUser = users[userIndex];
        users[userIndex] = UserModel.fromJson({
          ...listUser.toJson(),
          'name': fullName,
          'email': email,
          'company': company,
        });
      }
      await GetStorage().write(
        'updatedUser:${user.login}',
        updatedUser.toJson(),
      );

      clearForm();
      Get.back<void>();
      Helper.setSnackBar(
        message: 'User updated successfully.',
        type: SnackBarType.success,
      );
    } catch (e) {
      Helper.setSnackBar(
        message: 'Something went wrong. Please try again.',
        type: SnackBarType.error,
      );
    } finally {
      isLoading.value = DataLoad.done;
    }
  }

  Future<void> addUser() async {
    final email = emailController.value.text.trim();
    final fullName = fullNameController.value.text.trim();
    final company = companyController.value.text.trim();
    final login = fullName;

    try {
      isLoading.value = DataLoad.loading;
      final user = UserModel.fromJson({
        'login': login,
        'id': DateTime.now().millisecondsSinceEpoch,
        'node_id': login,
        'avatar_url': '',
        'gravatar_id': '',
        'url': '',
        'html_url': '',
        'followers_url': '',
        'following_url': '',
        'gists_url': '',
        'starred_url': '',
        'subscriptions_url': '',
        'organizations_url': '',
        'repos_url': '',
        'events_url': '',
        'received_events_url': '',
        'type': 'User',
        'user_view_type': 'public',
        'site_admin': false,
        'name': fullName,
        'email': email,
        'company': company,
      });

      final storage = GetStorage();
      final rawLocalUsers = storage.read<List<dynamic>>('local_users') ?? [];
      final localUsers = rawLocalUsers
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
      localUsers.add(user.toJson());
      await storage.write('local_users', localUsers);

      users.insert(0, user);
      clearForm();
      Get.back<void>();
      Helper.setSnackBar(
        message: 'User added successfully.',
        type: SnackBarType.success,
      );
    } catch (e) {
      Helper.setSnackBar(
        message: 'Something went wrong. Please try again.',
        type: SnackBarType.error,
      );
    } finally {
      isLoading.value = DataLoad.done;
    }
  }

  void _setUserDetail(UserDetailModel detail) {
    selectedUser.value = detail;
    fullNameController.value.text = detail.name ?? '';
    emailController.value.text = detail.email ?? '';
    companyController.value.text = detail.company ?? '';
  }

  String _errorMessage(int? statusCode, String? message, String action) {
    switch (statusCode) {
      case 401:
        return 'Unauthorized. A valid GitHub token is required.';
      case 403:
        return 'API rate limit exceeded. Please try again later.';
      case 404:
        return 'Data not found.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return message ?? 'Failed to $action.';
    }
  }
}
