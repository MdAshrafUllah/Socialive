class UserDatas {
  UserDatas(
      {required this.name,
      required this.userName,
      required this.userId,
      this.profileImageUrl,
      this.followerUidList,
      this.followingUidList});

  String name;
  String userName;
  String userId;
  String? profileImageUrl;
  List<String>? followerUidList;
  List<String>? followingUidList;
}
