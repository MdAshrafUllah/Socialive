import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String? uid;
  final String? name;
  final String? userName;
  final String? email;
  final String? profileImage;
  final List<String>? followers;
  final List<String>? following;
  final List<String>? posts;

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

  factory UserProfile.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProfile(
      uid: doc.id,
      name: data['name'] ?? '',
      userName: data['userName'] ?? '',
      email: data['email'] ?? '',
      profileImage: data['profileImage'] ?? '',
      followers: List<String>.from(data['followers'] ?? []),
      following: List<String>.from(data['following'] ?? []),
      posts: List<String>.from(data['posts'] ?? []),
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
      'posts': posts,
    };
  }
}
