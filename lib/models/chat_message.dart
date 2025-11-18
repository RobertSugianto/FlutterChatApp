class ChatMessage {
  final String text;
  final bool isUser;
  final String time;
  final bool isMedia;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.time,
    this.isMedia = false,
  });
}