import 'package:get/get.dart';

class FollowingFollowersListScreenController extends GetxController{
  bool isFollowingButtonSelected = true;

  void onClickFollowingButton(){
    if(isFollowingButtonSelected==false) isFollowingButtonSelected=true;
    update();
  }
  void onClickFollowersButton(){
    if(isFollowingButtonSelected==true) isFollowingButtonSelected=false;
    update();
  }

}