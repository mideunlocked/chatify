class Chat {
  final String id;
  final int timeStamp;
  final bool isMe;
  final bool isSeen;
  final bool isSent;
  final String text;
  final Map<String, dynamic> reply;

  const Chat({
    required this.id,
    required this.timeStamp,
    required this.reply,
    required this.isMe,
    required this.isSeen,
    required this.isSent,
    required this.text,
  });
}
