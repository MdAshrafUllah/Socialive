import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:socialive/Data/models/comment_model.dart';
import 'package:socialive/Data/models/post_model.dart';
import 'package:socialive/presentation/controllers/navigation/profile_screen_controller.dart';

final ProfileController profileController = Get.put(ProfileController());

class PostController extends GetxController {
  var isLiked = false.obs;
  var isSaved = false.obs;
  RxList<PostsModel> posts = <PostsModel>[].obs;
  @override
  void onInit() {
    getCurrentUserPosts();
    getFollowingUsersPosts();
    super.onInit();
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
  }

  void toggleSave() {
    isSaved.value = !isSaved.value;
  }

  Future<void> getCurrentUserPosts() async {
    final uid = profileController.uid;
    if (uid.isNotEmpty) {
      final profileRef =
          FirebaseFirestore.instance.collection('users').doc(uid);
      profileRef.snapshots().listen((docSnapshot) {
        final profileData = docSnapshot.data();
        if (profileData != null) {
          final profileImage = profileData["profileImage"] as String;
          final name = profileData["name"] as String;
          final userName = profileData["userName"] as String;
          profileRef
              .collection('posts')
              .orderBy('postTime', descending: true)
              .snapshots()
              .listen((querySnapshot) async {
            final List<PostsModel> currentUserPosts = [];
            for (var doc in querySnapshot.docs) {
              final postData = doc.data();
              final List<CommentModel> comments = [];
              for (var commentData in postData['commentCount'] as List) {
                final commentMap = commentData as Map<String, dynamic>;
                final userUID = commentMap['userUID'] as String;
                final commenterSnapshot = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(userUID)
                    .get();
                final commenterData = commenterSnapshot.data();
                if (commenterData != null) {
                  final comment = CommentModel(
                    userUID: userUID,
                    profileImage: commenterData['profileImage'] as String,
                    userName: commenterData['userName'] as String,
                    commentDescriptions:
                        commentMap['commentDescriptions'] as String,
                    commentLike: commentMap['commentLike'] as int,
                    timeDate: commentMap['timeDate'] as String,
                  );
                  comments.add(comment);
                }
              }
              final post = PostsModel(
                profileImage: profileImage,
                userName: userName,
                name: name,
                postImage: postData['postImage'] as String,
                postDescription: postData['postDescription'] as String,
                likeCount: postData['likeCount'] as int,
                comments: comments,
                postTime: (postData['postTime'] as Timestamp).toDate(),
              );
              currentUserPosts.add(post);
            }
            updatePosts(currentUserPosts);
          });
        }
      });
    }
  }

  Future<void> getFollowingUsersPosts() async {
    final uid = profileController.uid;
    if (uid.isNotEmpty) {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final followingUID =
          List<String>.from(userDoc.data()?['following'] ?? []);
      final List<PostsModel> followingPosts = [];
      for (String following in followingUID) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(following)
            .collection('posts')
            .orderBy('postTime', descending: true)
            .snapshots()
            .listen((postSnapshot) async {
          final List<PostsModel> fetchedPosts = await Future.wait(
            postSnapshot.docs.map((postDoc) async {
              final postData = postDoc.data();
              final List<CommentModel> comments = await Future.wait(
                (postData['commentCount'] as List).map((commentData) async {
                  final commentUID = commentData['userUID'] as String;
                  final userProfileSnapshot = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(commentUID)
                      .get();
                  final userProfileData = userProfileSnapshot.data()!;
                  return CommentModel(
                    userUID: commentUID,
                    profileImage: userProfileData['profileImage'] as String,
                    userName: userProfileData['userName'] as String,
                    commentDescriptions:
                        commentData['commentDescriptions'] as String,
                    commentLike: commentData['commentLike'] as int,
                    timeDate: commentData['timeDate'] as String,
                  );
                }).toList(),
              );
              final userProfileSnapshot = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(following)
                  .get();
              final userProfileData = userProfileSnapshot.data()!;
              return PostsModel(
                profileImage: userProfileData['profileImage'] as String,
                userName: userProfileData['userName'] as String,
                name: userProfileData['name'] as String,
                postImage: postData['postImage'] as String,
                postDescription: postData['postDescription'] as String,
                likeCount: postData['likeCount'] as int,
                comments: comments,
                postTime: (postData['postTime'] as Timestamp).toDate(),
              );
            }).toList(),
          );
          followingPosts.addAll(fetchedPosts);
          updatePosts(followingPosts);
        });
      }
    }
  }

  void updatePosts(List<PostsModel> newPosts) {
    final combinedPosts = [...posts, ...newPosts];
    combinedPosts.sort((a, b) => b.postTime.compareTo(a.postTime));
    posts.assignAll(combinedPosts);
  }
}
