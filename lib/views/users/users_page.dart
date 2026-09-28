import 'package:flutter/material.dart';
import 'package:flutter_test_gias/controllers/user/user_controller.dart';
import 'package:flutter_test_gias/routes/route_name.dart';
import 'package:flutter_test_gias/utilities/dimensions.dart';
import 'package:flutter_test_gias/utilities/enum/data_load.dart';
import 'package:flutter_test_gias/utilities/utilities.dart';
import 'package:flutter_test_gias/widgets/appbar/main_appbar.dart';
import 'package:flutter_test_gias/widgets/empty_banner/empty_banner_widget.dart';
import 'package:flutter_test_gias/widgets/shimmer/shimmer_list.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatelessWidget {
  UsersPage({super.key});

  final UserController userController = Get.put(UserController());

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userController.clearForm();
          Get.toNamed(RouteName.addUserPage);
        },
        backgroundColor: kColorPrimary,
        child: const Icon(
          Icons.add,
          color: kColorWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SmartRefresher(
        controller: userController.refreshController,
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: () async {
          await userController.fetchUsers();
          userController.refreshController.refreshCompleted();
        },
        onLoading: () async {
          await userController.fetchUsers();
          userController.refreshController.loadComplete();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: kPagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List of Users',
                  style: TStyle.poppins18Bold.copyWith(
                    color: kColorTextDefault,
                  ),
                ),

                const SizedBox(height: 12),

                Obx(() {
                  if (userController.isLoading.value == DataLoad.loading) {
                    return const ShimmerList(
                      count: 20,
                      heightCard: 80,
                      margin: EdgeInsets.only(bottom: 12),
                    );
                  }

                  if (userController.users.isEmpty) {
                    return EmptyBanner(
                      height: Get.height * 0.3,
                      description: 'No users found. Please try again later.',
                    );
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: userController.users.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: kColorWhite,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: kColorShadow,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              userController.fetchUserDetail(
                                userController.users[index].login,
                              );
                              Get.toNamed(RouteName.updateUserPage);
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: kColorBlue800,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child:
                                          userController
                                              .users[index]
                                              .avatarUrl
                                              .isEmpty
                                          ? const SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: Icon(
                                                Icons.person,
                                                color: kColorWhite,
                                              ),
                                            )
                                          : Image.network(
                                              userController
                                                  .users[index]
                                                  .avatarUrl,
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                    return const SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: Icon(
                                                        Icons.person,
                                                        color: kColorWhite,
                                                      ),
                                                    );
                                                  },
                                            ),
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userController.users[index].login,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TStyle.poppins18SemiBold
                                              .copyWith(
                                                color: kColorTextDefault,
                                              ),
                                        ),
                                        Text(
                                          userController.users[index].type,
                                          style: TStyle.poppins16Regular
                                              .copyWith(
                                                color: kColorTextDefault,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: kColorTextDefault,
                                    size: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
