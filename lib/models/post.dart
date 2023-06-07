import 'comment.dart';

class Post {
  final String id;
  final String text;
  final Map<String, dynamic> postUserInfo;
  final String time;
  final List<Comment> comments;
  final int likeCount;

  const Post({
    required this.id,
    required this.text,
    required this.postUserInfo,
    required this.time,
    required this.comments,
    required this.likeCount,
  });
}
