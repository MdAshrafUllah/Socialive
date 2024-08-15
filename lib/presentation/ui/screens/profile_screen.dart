import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/font_style.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import '../../controllers/profile_screen_controller.dart';
import '../../../Data/models/user_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.foregroundColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor:AppColors.secondaryColor
      // status bar color
    ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
        "https://media.ed.edmunds-media.com/gmc/sierra-3500hd/2018/td/2018_gmc_sierra-3500hd_f34_td_411183_1600.jpg",
        "https://www.galeanasvandykedodge.net/assets/stock/ColorMatched_01/White/640/cc_2018DOV170002_01_640/cc_2018DOV170002_01_640_PSC.jpg",
    ];

    UserData userData = UserData(
        name: "Ferdaous Mondal",
        userName: "@mferdous12",
        numberOfPost: 59,
        following: 125,
        follower: 850);
    Size deviceSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Column(
        children: [
          profileHeaderSection(deviceSize, userData),
          const SizedBox(height: 8),
          Container(
            height: deviceSize.height - deviceSize.height / 3.8 - 8,
            width: deviceSize.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: AppColors.foregroundColor,
            child: GetBuilder<ProfileScreenController>(
                builder: (profileScreenController) {
                  return Column(
                    children: [
                      gridOrListViewSelectorSection(deviceSize),
                      Visibility(
                        visible: profileScreenController.isGridViewSelected,
                        replacement: postListViewBuilder(images),
                        child: postGridViewBuilder(images),)
                    ],
                  );
                }
            ),
          )
        ],
      ),
    );
  }

  Expanded postListViewBuilder(List<String> images) {
    return Expanded(
                          child: ListView.builder(itemBuilder: (context,
                              index) {
                            return Card(
                                margin:const EdgeInsets.only(top :10), child: Image.network(images[index],
                                fit: BoxFit.cover));
                          }, shrinkWrap: true, itemCount: images.length,));
  }

  Expanded postGridViewBuilder(List<String> images) {
    return Expanded(
        child: GridView.custom(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: [
              QuiltedGridTile(2, 2),
              QuiltedGridTile(1, 2),
              QuiltedGridTile(1, 2),
              //QuiltedGridTile(1, 1),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: images.length,
                (context, index) =>
                Card(child: Image.network(images[index], fit: BoxFit.cover,),),
          ),
          shrinkWrap: true,
        )
    );
  }

  Column gridOrListViewSelectorSection(Size deviceSize) {
    return Column(
      children: [
        Stack(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 1,
                      width: deviceSize.width - 32,
                      child: ColoredBox(
                          color: AppColors.textLightColor.withOpacity(0.3)),
                    ),
                  ],
                )
              ],
            ),
            GetBuilder<ProfileScreenController>(
                builder: (profileScreenController) {
                  return Row(
                    children: [
                      Spacer(),
                      postListLayout(() {
                        profileScreenController.clickOnGridView();
                      }, "Grid View", AssetsPath.grid,
                          profileScreenController.isGridViewSelected),
                      const SizedBox(width: 16),
                      postListLayout(() {
                        profileScreenController.clickOnListView();
                      }, "List View", AssetsPath.list,
                          !profileScreenController.isGridViewSelected),
                      const Spacer()
                    ],
                  );
                }),
          ],
        )
      ],
    );
  }

  Widget postListLayout(dynamic onTap, String buttonName,
      String iconPath, bool isSelected) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: isSelected
                        ? AppColors.secondaryColor
                        : Colors.transparent))),
        child: Center(
            child: Row(
              children: [
                SvgPicture.asset(
                  iconPath,
                  height: 16,
                ),
                SizedBox(width: 2),
                Text(
                  buttonName,
                  style: FontStyle.satoshi500S12,
                ),
              ],
            )),
      ),
    );
  }

  Container profileHeaderSection(Size deviceSize, UserData userdata) {
    return Container(
      height: deviceSize.height / 3.8,
      color: AppColors.foregroundColor,
      padding: const EdgeInsets.all(10),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 38),
          const Text("My Profile", style: FontStyle.satoshi700S20),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://github.com/Rayhan-Sany/Rayhan-Sany/blob/main/Rayhan2-1-01-01-01-01-01.jpeg?raw=true"),
                minRadius: 40,
              ),
              SizedBox(width: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userdata.name, style: FontStyle.satoshi700S18),
                  Text(
                    userdata.userName,
                    style: FontStyle.satoshi400S12
                        .copyWith(color: AppColors.textLightColor),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    children: [
                      Text(
                        "${userdata.numberOfPost}",
                        style: FontStyle.satoshi500S12,
                      ),
                      Text(
                        "Post",
                        style: FontStyle.satoshi400S12
                            .copyWith(color: AppColors.textLightColor),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${userdata.following}",
                        style: FontStyle.satoshi500S12,
                      ),
                      Text(
                        "Following",
                        style: FontStyle.satoshi400S12
                            .copyWith(color: AppColors.textLightColor),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${userdata.follower}",
                        style: FontStyle.satoshi500S12,
                      ),
                      Text(
                        "Follower",
                        style: FontStyle.satoshi400S12
                            .copyWith(color: AppColors.textLightColor),
                      ),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
