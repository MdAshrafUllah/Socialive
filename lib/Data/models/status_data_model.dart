import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  final List<String> statusImages;

  Status({required this.statusImages});

  factory Status.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final images = List<String>.from(data['statusImages'] ?? []);
    return Status(
      statusImages: images,
    );
  }
}
