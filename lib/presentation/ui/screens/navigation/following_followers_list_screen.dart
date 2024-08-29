import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/following_followers_list_screen_controller.dart';
import 'package:socialive/presentation/ui/widgets/back_button_with_tittle.dart';
import 'package:socialive/presentation/ui/widgets/followers_list_widget.dart';
import 'package:socialive/presentation/ui/widgets/profile/follow_followers_switch_widget.dart';
import 'package:socialive/presentation/ui/widgets/search_text_field_widget.dart';
import 'package:socialive/presentation/ui/widgets/show_alert_dialog.dart';

class FollowingFollowerListScreen extends StatelessWidget {
  const FollowingFollowerListScreen({super.key, required this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    TextEditingController searchTEController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
        child: Column(
          children: [
            backButtonWithTittle(title: name!),
            const SizedBox(height: 10),
            followingFollowerSelectionSection(),
            Divider(
              color: AppColors.secondaryColor.withOpacity(0.1),
              height: 1,
              thickness: 1.5,
            ),
            const SizedBox(height: 15),
            SearchTextFieldWidget(searchTEController: searchTEController),
            Expanded(
              child: Obx(() {
                final followerListController =
                    Get.find<FollowingFollowersListScreenController>();

                final usersList = followerListController.isFollowingScreen.value
                    ? followerListController.followingProfiles
                    : followerListController.followersProfiles;

                if (usersList.isEmpty) {
                  return const Center(child: Text("No users found"));
                }

                return ListView.builder(
                  itemCount: usersList.length,
                  itemBuilder: (context, index) {
                    bool isFollower = false;
                    final user = usersList[index];
                    for (String uid in followerListController.followingList) {
                      if (user.uid == uid) {
                        isFollower = true;
                      }
                    }
                    return userListWidget(
                      name: user.name ?? '',
                      profileImage: user.profileImage ?? '',
                      userName: "@${user.userName}",
                      isFollowing: isFollower,
                      onTap: () {
                        showAlertDialog(
                            title:
                                "Are you sure you want to ${isFollower ? 'unfollow' : 'follow'} ${user.name}?",
                            elevatedBtnName: isFollower ? "Unfollow" : "Follow",
                            textBtnName: "Cancel",
                            onElevatedBtnPressed: () {
                              followerListController.toggleFollow(user.uid);
                              Get.back();
                            },
                            skipBtn: true);
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
