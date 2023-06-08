import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String text;
  final Map<String, dynamic> postUserInfo;
  final Timestamp time;
  final List<dynamic> likeCount;

  const Post({
    required this.id,
    required this.text,
    required this.postUserInfo,
    required this.time,
    required this.likeCount,
  });
}
