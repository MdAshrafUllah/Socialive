import 'package:flutter/material.dart';
import 'package:socialive/Data/demo_data/posts_data.dart';
import 'package:socialive/Data/demo_data/status_data.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import 'package:socialive/presentation/ui/widgets/app_logo.dart';
import 'package:socialive/presentation/ui/widgets/home/home_screen_icons_widget.dart';
import 'package:socialive/presentation/ui/widgets/home/no_posts_message.dart';
import 'package:socialive/presentation/ui/widgets/profile/profile_picture_widget.dart';
import 'package:socialive/presentation/ui/widgets/home/status_widget.dart';
import 'package:socialive/presentation/ui/widgets/home/timeline_posts_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColors.textLightColor.withOpacity(0.2),
        body: RefreshIndicator(
          onRefresh: () async {},
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: AppColors.foregroundColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.06,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            currentUserProfilePicture(
                              minRadius: 20,
                            ),
                            const Spacer(),
                            const AppLogo(),
                            const Spacer(),
                            iconWithBG(imgPath: AssetsPath.notification),
                            const SizedBox(width: 10),
                            iconWithBG(imgPath: AssetsPath.message),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: SizedBox(
                          height: 155,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: status.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: currentUserStatusBox(),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: othersStatusBox(
                                    profileImage: status[index - 1]
                                        ['profileImage']!,
                                    statusImage: status[index - 1]
                                        ['statusImage']!,
                                    userName: status[index - 1]['userName']!,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 15)
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 15),
                  itemCount: posts.length + 1,
                  itemBuilder: (context, index) {
                    if (index == posts.length) {
                      return noMorePosts();
                    } else {
                      return PostWidget(
                        profileImage: posts[index]["profileImage"],
                        username: posts[index]["username"],
                        handle: posts[index]["handle"],
                        postImage: posts[index]["postImage"],
                        commentCount: posts[index]["commentCount"],
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
