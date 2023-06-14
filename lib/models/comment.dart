import 'package:cloud_firestore/cloud_firestore.dart';

import 'post.dart';

class Comment {
  final String id;
  final Post post;
  final Timestamp time;
  final String comment;
  final List<dynamic> likeCount;
  final List<dynamic> disLikeCount;
  final Map<String, dynamic> commenter;

  const Comment({
    required this.id,
    required this.post,
    required this.time,
    required this.comment,
    required this.commenter,
    required this.likeCount,
    required this.disLikeCount,
  });
}
