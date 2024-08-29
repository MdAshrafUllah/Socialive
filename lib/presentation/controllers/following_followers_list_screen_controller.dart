import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:socialive/Data/models/user_datas.dart';
import 'package:socialive/presentation/controllers/loading_controller.dart';

final LoadingController loadingController = Get.find<LoadingController>();
class FollowingFollowersListScreenController extends GetxController {
  bool isFollowingButtonSelected = true;
  List<UserDatas> userDataList = [];

  Future<void> onClickFollowingButton() async{
    if (isFollowingButtonSelected == false) {
      isFollowingButtonSelected=true;
      userDataList.clear();
     await getFollowingsUserData();
    }
  }

  void onClickFollowersButton() {

    if (isFollowingButtonSelected == true) {
      isFollowingButtonSelected = false;

      loadingController.showLoading();
      FirebaseFirestore db = FirebaseFirestore.instance;
      List<dynamic> followersUserId = [];
      final docRef = db.collection("users").doc("vL0XKsHGiQV3GCXa00ads9qdgUO2");
      docRef.get().then(
            (DocumentSnapshot doc) async {
          final data =  doc.data() as Map<String, dynamic>;
          //print(data);
          followersUserId = data["followers"];
          print(followersUserId);

          for (int i = 0; i < followersUserId.length; i++) {
            final docRef = db.collection("users").doc(followersUserId[i].toString());
            await docRef.get().then(
                  (DocumentSnapshot doc) {
                final data = doc.data() as Map<String, dynamic>;

                UserDatas userData = UserDatas(
                    name: data["name"],
                    userName: data["username"],
                    userId: data["uid"],
                    profileImageUrl:data["profileImage"]);
                userDataList.add(userData);
                print(userDataList[0].profileImageUrl);
              },
              onError: (e) => print("Error getting document: $e"),
            );
          }
          // ...
        },
        onError: (e) => print("Error getting document: $e"),
      );

      update();
      loadingController.hideLoading();
    }
  }

  Future<void> getFollowingsUserData() async{
    loadingController.showLoading();
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<dynamic> followingUserId = [];
    final docRef = db.collection("users").doc("vL0XKsHGiQV3GCXa00ads9qdgUO2");
    docRef.get().then(
          (DocumentSnapshot doc) async {
        final data =  doc.data() as Map<String, dynamic>;
        //print(data);
        followingUserId = data["following"];
        print(followingUserId);

        for (int i = 0; i < followingUserId.length; i++) {
          final docRef = db.collection("users").doc(followingUserId[i].toString());
        await docRef.get().then(
                (DocumentSnapshot doc) {
              final data = doc.data() as Map<String, dynamic>;

              UserDatas userData = UserDatas(
                  name: data["name"],
                  userName: data["username"],
                  userId: data["uid"],
                  profileImageUrl:data["profileImage"]);
              userDataList.add(userData);
              print(userDataList[0].profileImageUrl);
            },
            onError: (e) => print("Error getting document: $e"),
          );
        }
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );

    update();
    loadingController.hideLoading();
  }

}
