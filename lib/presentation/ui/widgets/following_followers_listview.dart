import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/controllers/following_followers_list_screen_controller.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';

class FollowingFollowersListView extends StatefulWidget {
  const FollowingFollowersListView({super.key});

  @override
  State<FollowingFollowersListView> createState() =>
      _FollowingFollowersListViewState();
}

class _FollowingFollowersListViewState
    extends State<FollowingFollowersListView> {
  @override
  void initState() {
    // TODO: implement initState
    final followingFollowersListScreenController=Get.find<FollowingFollowersListScreenController>();
    if(followingFollowersListScreenController.isFollowingButtonSelected){
      followingFollowersListScreenController.getFollowingsUserData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FollowingFollowersListScreenController>(
        builder: (followingFollowersListScreenController) {
      return Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text(
                  followingFollowersListScreenController
                      .userDataList[index].name,
                  style: AppFontStyle.satoshi700S14),
              subtitle: Text(
                followingFollowersListScreenController
                    .userDataList[index].userName,
                style: AppFontStyle.satoshi400S12
                    .copyWith(color: AppColors.textLightColor),
              ),
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      followingFollowersListScreenController
                              .userDataList[index].profileImageUrl ??
                          AssetsPath.blankProfileImage)),
              trailing: TextButton(
                  onPressed: () {},
                  child: followingFollowersListScreenController
                          .isFollowingButtonSelected
                      ? Text("Unfollow")
                      : Text("Remove")),
            );
          },
          itemCount: Get.find<FollowingFollowersListScreenController>()
              .userDataList
              .length,
          shrinkWrap: true,
        ),
      );
    });
  }
}
