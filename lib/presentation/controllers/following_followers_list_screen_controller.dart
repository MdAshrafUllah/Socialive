import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:socialive/Data/models/user_profile_model.dart';
import 'package:socialive/presentation/controllers/navigation/profile_screen_controller.dart';
import 'package:socialive/presentation/controllers/widget/loading_controller.dart';

final LoadingController loadingController = Get.find<LoadingController>();
final ProfileController _profileController = Get.find<ProfileController>();

class FollowingFollowersListScreenController extends GetxController {
  RxList followingProfiles = <UserProfile>[].obs;
  RxList followersProfiles = <UserProfile>[].obs;
  RxBool isFollowingScreen = true.obs;
  RxList<String> followingList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFollowingProfiles();
    fetchFollowersProfiles();
  }

  void switchFollowToFollowers() {
    isFollowingScreen.value = !isFollowingScreen.value;
  }

  void fetchFollowingProfiles() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(_profileController.uid)
        .snapshots()
        .listen((DocumentSnapshot userDoc) {
      if (userDoc.exists) {
        followingList = RxList<String>.from(userDoc['following'] ?? []);
        followingProfiles.clear();
        for (String uid in followingList) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .snapshots()
              .listen((DocumentSnapshot profileDoc) {
            if (profileDoc.exists) {
              UserProfile userProfile = UserProfile.map(profileDoc);
              int index =
                  followingProfiles.indexWhere((profile) => profile.uid == uid);
              if (index == -1) {
                followingProfiles.add(userProfile);
              } else {
                followingProfiles[index] = userProfile;
              }
            }
          });
        }
      }
    });
  }

  void fetchFollowersProfiles() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(_profileController.uid)
        .snapshots()
        .listen((DocumentSnapshot userDoc) {
      if (userDoc.exists) {
        List<String> followingUIDList =
            List<String>.from(userDoc['followers'] ?? []);
        followersProfiles.clear();
        for (String uid in followingUIDList) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .snapshots()
              .listen((DocumentSnapshot profileDoc) {
            if (profileDoc.exists) {
              UserProfile userProfile = UserProfile.map(profileDoc);
              int index =
                  followersProfiles.indexWhere((profile) => profile.uid == uid);
              if (index == -1) {
                followersProfiles.add(userProfile);
              } else {
                followersProfiles[index] = userProfile;
              }
            }
          });
        }
      }
    });
  }

  void toggleFollow(String uid) {
    for (String user in followingList) {
      if (user != uid) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(_profileController.uid)
            .update({
          'following': FieldValue.arrayUnion([uid])
        });
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(_profileController.uid)
            .update({
          'following': FieldValue.arrayRemove([uid])
        });
      }
    }
  }
}
