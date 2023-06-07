class Comment {
  final String time;
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
