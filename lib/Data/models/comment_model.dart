class CommentModel {
  final String userUID;
  final String profileImage;
  final String userName;
  final String commentDescriptions;
  final int commentLike;
  final String timeDate;

  CommentModel({
    required this.userUID,
    required this.profileImage,
    required this.userName,
    required this.commentDescriptions,
    required this.commentLike,
    required this.timeDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userUID': userUID,
      'profileImage': profileImage,
      'userName': userName,
      'commentDescriptions': commentDescriptions,
      'commentLike': commentLike,
      'timeDate': timeDate,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      userUID: map['userUID'] as String,
      profileImage: map['profileImage'] as String,
      userName: map['userName'] as String,
      commentDescriptions: map['commentDescriptions'] as String,
      commentLike: map['commentLike'] as int,
      timeDate: map['timeDate'] as String,
    );
  }
}
