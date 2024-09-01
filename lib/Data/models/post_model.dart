import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialive/Data/models/comment_model.dart';

class PostsModel {
  final String profileImage;
  final String name;
  final String userName;
  final List<String> postImage;
  final String postDescription;
  final List<CommentModel> comments;
  final int likeCount;
  final DateTime postTime;
  final String postId;
  final String postUserId;

  PostsModel({
    required this.profileImage,
    required this.name,
    required this.userName,
    required this.postImage,
    required this.postDescription,
    required this.comments,
    required this.likeCount,
    required this.postTime,
    required this.postId,
    required this.postUserId,
  });

  factory PostsModel.fromFirestore(Map<String, dynamic> map) {
    return PostsModel(
      postId: map['postId'] as String,
      postUserId: map['postUserId'] as String,
      profileImage: map['profileImage'] as String,
      name: map['name'] as String,
      userName: map['userName'] as String,
      postImage: map['postImage'] as List<String>,
      postDescription: map['postDescription'] as String,
      comments: (map['commentCount'] as List)
          .map((comment) =>
              CommentModel.fromMap(comment as Map<String, dynamic>))
          .toList(),
      likeCount: map['likeCount'] as int,
      postTime: (map['postTime'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'postUserId': postUserId,
      'profileImage': profileImage,
      'name': name,
      'userName': userName,
      'postImage': postImage,
      'postDescription': postDescription,
      'commentCount': comments.map((comment) => comment.toMap()).toList(),
      'likeCount': likeCount,
      'postTime': Timestamp.fromDate(postTime),
    };
  }
}
