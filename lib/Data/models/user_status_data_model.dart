class StatusUserProfile {
  final String uid;
  final String name;
  final String profileImage;
  final List<String> status;

  StatusUserProfile({
    required this.uid,
    required this.name,
    required this.profileImage,
    required this.status,
  });

  factory StatusUserProfile.fromMap(Map<String, dynamic> data, String uid) {
    return StatusUserProfile(
      uid: uid,
      name: data['name'] ?? '',
      profileImage: data['profileImage'] ?? '',
      status: List<String>.from(data['status'] ?? []),
    );
  }
}
