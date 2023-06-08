import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final Timestamp time;
  final String comment;
  final int likeCount;
  final int disLikeCount;
  final Map<String, dynamic> commenter;

  const Comment({
    required this.time,
    required this.comment,
    required this.commenter,
    required this.likeCount,
    required this.disLikeCount,
  });
}
