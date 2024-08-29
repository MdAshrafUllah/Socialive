import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/main_bottom_controller.dart';
import 'package:socialive/presentation/ui/screens/navigation/home/home_screen.dart';
import 'package:socialive/presentation/ui/screens/navigation/profile_screen.dart';
import 'package:socialive/presentation/ui/screens/navigation/search_screen.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';

class MainBottomNavigation extends StatefulWidget {
  const MainBottomNavigation({super.key});

  @override
  State<MainBottomNavigation> createState() => _MainBottomNavigationState();
}

class _MainBottomNavigationState extends State<MainBottomNavigation> {
  final MainBottomNavigationController _mainBottomController =
      Get.put(MainBottomNavigationController());

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    const SizedBox(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Center(
            child: _widgetOptions
                .elementAt(_mainBottomController.selectedIndex.value),
          )),
      bottomNavigationBar: Obx(() => Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: AppColors.foregroundColor,
              items: [
                _buildBottomNavigationBarItem(
                  bottomIconsStyle(
                    AssetsPath.home,
                    index: 0,
                    selected: _mainBottomController.selectedIndex.value == 0,
                  ),
                  0,
                ),
                _buildBottomNavigationBarItem(
                  bottomIconsStyle(
                    AssetsPath.search,
                    index: 1,
                    selected: _mainBottomController.selectedIndex.value == 1,
                  ),
                  1,
                ),
                _buildBottomNavigationBarItem(
                  bottomIconsStyle(
                    AssetsPath.add,
                    index: 2,
                    selected: _mainBottomController.selectedIndex.value == 2,
                  ),
                  2,
                ),
                _buildBottomNavigationBarItem(
                  bottomIconsStyle(
                    AssetsPath.profile,
                    index: 3,
                    selected: _mainBottomController.selectedIndex.value == 3,
                  ),
                  3,
                ),
              ],
              currentIndex: _mainBottomController.selectedIndex.value,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: AppColors.textLightColor,
              onTap: _mainBottomController.onItemTapped,
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          )),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      Widget iconData, int index) {
    final selected = index == _mainBottomController.selectedIndex.value;
    return BottomNavigationBarItem(
      icon: _buildIcon(iconData, selected),
      label: '',
    );
  }

  Widget _buildIcon(Widget iconData, bool selected) {
    final bgColor = selected
        ? AppColors.activeBottomNevItemColor
        : AppColors.transparentColor;
    return Container(
      width: 95,
      height: 55,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(child: iconData),
    );
  }
}

Widget bottomIconsStyle(String path,
    {required int index, required bool selected}) {
  return SvgPicture.asset(
    path,
    height: 30,
    width: 30,
    colorFilter: ColorFilter.mode(
      selected ? AppColors.primaryColor : AppColors.secondaryColor,
      BlendMode.srcIn,
    ),
  );
}
