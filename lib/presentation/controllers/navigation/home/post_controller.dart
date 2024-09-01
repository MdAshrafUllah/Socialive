import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:socialive/Data/models/comment_model.dart';
import 'package:socialive/Data/models/post_model.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/navigation/profile/profile_screen_controller.dart';
import 'package:socialive/presentation/ui/widgets/loading_widget.dart';

final profileController = Get.find<ProfileController>();

class PostController extends GetxController {
  var isLiked = false.obs;
  var isSaved = false.obs;
  RxList<PostsModel> posts = <PostsModel>[].obs;
  RxList<String> currentUserAllPosts = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllPosts();
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
  }

  void toggleSave() {
    isSaved.value = !isSaved.value;
  }

  void fetchAllPosts() {
    posts.clear();
    currentUserAllPosts.clear();
    getCurrentUserPosts();
    getFollowingUsersPosts();
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
              final postImage =
                  (postData['postImage'] as List<dynamic>).cast<String>();
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
              currentUserAllPosts.add(postImage.first);
              final post = PostsModel(
                postUserId: uid,
                profileImage: profileImage,
                userName: userName,
                name: name,
                postImage: postImage,
                postDescription: postData['postDescription'] as String,
                likeCount: postData['likeCount'] as int,
                comments: comments,
                postTime: (postData['postTime'] as Timestamp).toDate(),
                postId: postData['postId'],
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
              final postImage =
                  (postData['postImage'] as List<dynamic>).cast<String>();
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
                postUserId: userProfileData['uid'] as String,
                profileImage: userProfileData['profileImage'] as String,
                userName: userProfileData['userName'] as String,
                name: userProfileData['name'] as String,
                postImage: postImage,
                postDescription: postData['postDescription'] as String,
                likeCount: postData['likeCount'] as int,
                comments: comments,
                postTime: (postData['postTime'] as Timestamp).toDate(),
                postId: postData['postId'],
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
    final uniquePosts = <PostsModel>{}.union(combinedPosts.toSet()).toList();
    uniquePosts.sort((a, b) => b.postTime.compareTo(a.postTime));
    posts.assignAll(uniquePosts);
  }

  Future<void> deletePost(String postId) async {
    try {
      loadingController.showLoading();
      final uid = profileController.uid;
      if (uid.isNotEmpty) {
        final postRef = FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('posts')
            .doc(postId);

        await postRef.delete();

        posts.removeWhere((post) => post.postImage.contains(postId));
        currentUserAllPosts.remove(postId);

        updatePosts(posts);
      }
      loadingController.hideLoading();
      Get.snackbar(
        'Success',
        'Post deleted successfully!',
        backgroundColor: AppColors.successColor,
        colorText: AppColors.foregroundColor,
      );
      fetchAllPosts();
    } catch (e) {
      loadingController.hideLoading();
      Get.snackbar(
        'Failed',
        'Failed to delete Post. ${e.toString()}',
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.foregroundColor,
      );
    }
  }
}
