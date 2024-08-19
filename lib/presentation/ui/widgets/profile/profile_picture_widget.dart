import 'package:flutter/material.dart';
import 'package:socialive/app/utility/app_colors.dart';

Widget currentUserProfilePicture({double? minRadius, bool haveStatus = false}) {
  return Container(
    decoration: BoxDecoration(
        color: haveStatus ? AppColors.primaryColor : AppColors.foregroundColor,
        borderRadius: BorderRadius.circular(50)),
    child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: CircleAvatar(
          backgroundImage: const AssetImage(
            "assets/images/profile/profile.png",
          ),
          minRadius: minRadius,
          backgroundColor: AppColors.primaryColor.withOpacity(0.22),
        )),
  );
}

Widget currentUserStatusProfilePicture() {
  return SizedBox(
    height: 120,
    width: 95,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Stack(children: [
        SizedBox(
          height: 120,
          width: 95,
          child: Image.asset(
            "assets/images/profile/profile.png",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: AppColors.secondaryColor.withOpacity(0.15),
        )
      ]),
    ),
  );
}

Widget othersStatusProfilePicture({required String profilePicture}) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.primaryColor, borderRadius: BorderRadius.circular(50)),
    child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: CircleAvatar(
          backgroundImage: AssetImage(
            profilePicture,
          ),
          backgroundColor: AppColors.primaryColor.withOpacity(0.22),
        )),
  );
}

Widget othersStatusPicture({required String statusPicture}) {
  return SizedBox(
    height: 120,
    width: 95,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Stack(children: [
        SizedBox(
          height: 120,
          width: 95,
          child: Image.asset(
            statusPicture,
            fit: BoxFit.cover,
          ),
        ),
      ]),
    ),
  );
}
