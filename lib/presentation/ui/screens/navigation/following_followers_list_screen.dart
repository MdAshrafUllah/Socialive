import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/controllers/following_followers_list_screen_controller.dart';
import 'package:socialive/presentation/ui/widgets/back_button_with_tittle.dart';
import 'package:socialive/presentation/ui/widgets/following_followers_listview.dart';
import '../../widgets/search_text_field_widget.dart';

class FollowingFollowerListScreen extends StatelessWidget {
  const FollowingFollowerListScreen({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    TextEditingController searchTEController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
        child: Column(
          children: [
            backButtonWithTittle(title: name),
            const SizedBox(height: 10),
             followingFollowerSelectionSection(),
            Divider(
              color: AppColors.secondaryColor.withOpacity(0.1),
              height: 1,
              thickness: 1.5,
            ),
            SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
              child:
                  SearchTextFieldWidget(searchTEController: searchTEController),
            ),
            FollowingFollowersListView()
          ],
        ),
      ),
    );
  }

  Widget followingFollowerSelectionSection(
          ) {
    return GetBuilder<FollowingFollowersListScreenController>(
      builder: (followingFollowersListScreenController) {
        return Row(
          children: [
            GestureDetector(
                onTap: () {
                  followingFollowersListScreenController.onClickFollowingButton();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: followingFollowersListScreenController
                                      .isFollowingButtonSelected
                                  ? AppColors.secondaryColor
                                  : Colors.transparent,
                              width: 1.4))),
                  child: Center(
                    child: Text("Following", style: AppFontStyle.satoshi500S14),
                  ),
                )),
            SizedBox(width: 15),
            GestureDetector(
                onTap: () {
                  followingFollowersListScreenController.onClickFollowersButton();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: !followingFollowersListScreenController
                                      .isFollowingButtonSelected
                                  ? AppColors.secondaryColor
                                  : Colors.transparent,
                              width: 1.4))),
                  child: Center(
                    child: Text("Follower", style: AppFontStyle.satoshi500S14),
                  ),
                )),
          ],
        );
      }
    );
  }
}
