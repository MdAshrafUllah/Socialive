import 'package:socialive/Data/models/post_model.dart';

class UserProfile {
  final String? uid;
  final String? name;
  final String? userName;
  final String? email;
  final String? profileImage;
  final List<String>? followers;
  final List<String>? following;
  final List<PostsModel>? posts;

  UserProfile({
    this.uid,
    this.name,
    this.userName,
    this.email,
    this.profileImage,
    this.followers,
    this.following,
    this.posts,
  });

  factory UserProfile.map(doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProfile(
      uid: doc.id,
      name: data['name'] ?? '',
      userName: data['userName'] ?? '',
      email: data['email'] ?? '',
      profileImage: data['profileImage'] ?? '',
      followers: List<String>.from(data['followers'] ?? []),
      following: List<String>.from(data['following'] ?? []),
      posts: (data['posts'] as List<dynamic>?)
          ?.map((post) => PostsModel.fromFirestore(post))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userName': userName,
      'email': email,
      'profileImage': profileImage,
      'followers': followers,
      'following': following,
      'posts': posts?.map((post) => post.toMap()).toList(),
    };
  }
}
