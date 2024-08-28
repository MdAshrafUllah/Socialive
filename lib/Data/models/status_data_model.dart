import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  final List<String> statusImages;
  final String statusUID;
  final String date;

  Status({
    required this.statusImages,
    required this.statusUID,
    required this.date,
  });

  factory Status.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Status(
      statusImages: List<String>.from(data['statusImages'] ?? []),
      statusUID: data['statusUID'] ?? '',
      date: data['date'] ?? '',
    );
  }
}
