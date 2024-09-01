import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/presentation/controllers/navigation/profile/following_followers_list_screen_controller.dart';
import 'package:socialive/presentation/controllers/navigation/profile/profile_screen_controller.dart';
import 'package:socialive/presentation/controllers/navigation/search_screen_controller.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import 'package:socialive/presentation/ui/widgets/followers_list_widget.dart';
import 'package:socialive/presentation/ui/widgets/search_text_field_widget.dart';
import 'package:socialive/presentation/ui/widgets/show_alert_dialog.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchScreenController = Get.find<SearchScreenController>();
  final profileController = Get.find<ProfileController>();
  final followingListController = Get.find<FollowingFollowersListController>();
  TextEditingController searchTEController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchTEController.addListener(() {
      searchScreenController.searchUsers(searchTEController.text.trim());
    });
  }

  @override
  void dispose() {
    searchTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            SearchTextFieldWidget(searchTEController: searchTEController),
            Expanded(
              child: Obx(() {
                if (searchScreenController.searchResults.isEmpty) {
                  return const Center(child: Text("Search users"));
                }

                return ListView.builder(
                  itemCount: searchScreenController.searchResults.length,
                  itemBuilder: (context, index) {
                    final user = searchScreenController.searchResults[index];
                    final isFollowing = followingListController.followingList
                        .contains(user.uid);
                    return userListWidget(
                      showFollowButton:
                          user.uid == profileController.uid ? false : true,
                      name: user.name ?? '',
                      profileImage: user.profileImage ?? '',
                      userName: "@${user.userName}",
                      isFollowing: isFollowing,
                      onFollowTap: () {
                        showAlertDialog(
                          topIcons: Image.asset(AssetsPath.alert),
                          title:
                              "Are you sure you want to ${isFollowing ? 'unfollow' : 'follow'} ${user.name}?",
                          elevatedBtnName: isFollowing ? "Unfollow" : "Follow",
                          textBtnName: "Cancel",
                          onElevatedBtnPressed: () {
                            followingListController
                                .toggleFollow(user.uid.toString());
                            Get.back();
                          },
                          skipBtn: true,
                        );
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
