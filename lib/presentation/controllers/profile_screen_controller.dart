import 'package:get/get.dart';

class ProfileScreenController extends GetxController{
  bool isGridViewSelected = true;

  void clickOnGridView (){
   if(isGridViewSelected==false) isGridViewSelected=true;
   update();
  }

  void clickOnListView (){
    if(isGridViewSelected==true) isGridViewSelected=false;
    update();
  }

}