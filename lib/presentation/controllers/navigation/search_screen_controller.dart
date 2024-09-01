import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:socialive/Data/models/user_profile_model.dart';

class SearchScreenController extends GetxController {
  RxList<UserProfile> searchResults = <UserProfile>[].obs;

  Future<void> searchUsers(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    final users = snapshot.docs.map((doc) => UserProfile.map(doc)).toList();
    searchResults.value = users;
  }

  void clearSearch() {
    searchResults.clear();
  }
}
