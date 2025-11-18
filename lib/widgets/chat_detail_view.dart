import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../services/gemini_service.dart';
import 'message_bubble.dart';

class ChatDetailView extends StatefulWidget {
  final String userName;
  const ChatDetailView({required this.userName, super.key});

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  final TextEditingController _controller = TextEditingController();
  final GeminiService _geminiService = GeminiService(); 

  final List<ChatMessage> _messages = [
    ChatMessage(text: "Thank you, we'll check this for you.", isUser: false, time: '9:36 AM'), 
    ChatMessage(text: "[Image/File Placeholder: log.txt]", isUser: true, time: '9:34 AM', isMedia: true), 
    ChatMessage(text: "[Image/File Placeholder: error screenshot]", isUser: true, time: '9:34 AM', isMedia: true), 
    ChatMessage(text: "Please send a screenshot of the error", isUser: false, time: '9:34 AM'), 
    ChatMessage(text: "I can't log in to the app.", isUser: true, time: '9:32 AM'), 
  ];

  void _handleSubmitted(String text) async {
    final userMessage = text.trim();
    if (userMessage.isEmpty) return;
    _controller.clear();

    setState(() {
      _messages.insert(0, ChatMessage(text: userMessage, isUser: true, time: 'Now'));
    });

    String geminiResponse = await _geminiService.sendMessage(userMessage); 

    setState(() {
      _messages.insert(0, ChatMessage(text: geminiResponse, isUser: false, time: 'Now'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Helpdesk Chat - ${widget.userName}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Divider(height: 1.0),
        // Message List Area
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            reverse: true, 
            itemCount: _messages.length,
            itemBuilder: (_, int index) => MessageBubble(message: _messages[index]),
          ),
        ),
        const Divider(height: 1.0),
        // Input Area
        _buildTextComposer(),
      ],
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.attachment),
            onPressed: () { /* Handle file/image attachment */ },
          ),
          Flexible(
            child: TextField(
              controller: _controller,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(
                hintText: "Message", 
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () => _handleSubmitted(_controller.text),
          ),
        ],
      ),
    );
  }
}