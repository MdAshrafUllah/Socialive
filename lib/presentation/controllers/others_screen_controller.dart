import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OthersScreenController extends GetxController {
  RxMap<String, dynamic> userInfo = <String, dynamic>{}.obs;
  RxList<List<String>> userPosts = <List<String>>[].obs;

  @override
  void onInit() {
    clearData();
    super.onInit();
  }

  void clearData() {
    userInfo.clear();
    userPosts.clear();
  }

  Future<void> fetchUserData({required String uid}) async {
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null) {
          userInfo.value = {
            'followers': (userData['followers'] as List<dynamic>?)?.length ?? 0,
            'following': (userData['following'] as List<dynamic>?)?.length ?? 0,
            'bio': userData['bio'] ?? 'No Bio',
          };
        }
      }

      final postsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('posts')
          .get();

      userPosts.clear();

      for (var postDoc in postsSnapshot.docs) {
        final List<String> postImages =
            List<String>.from(postDoc['postImage'] ?? []);
        userPosts.add(postImages);
      }
    } catch (e) {
      log('Error fetching user data: $e');
    }
  }
}
