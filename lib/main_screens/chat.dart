import 'package:auto_aid/decoration/chat_bubble.dart';
import 'package:flutter/material.dart';
import '../open_ai_service.dart';

class ChatScreen extends StatefulWidget {
  static String id='ChatPage';

  const ChatScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatBubble> _messages = [];
  final OpenAIService _openAIService = OpenAIService('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');

  void _sendMessage(String message) async {
    setState(() {
      _messages.add(
          ChatBubble(
        message: message,
        isSentByUser: true,
      ));
    });

    try {
      final response = await _openAIService.sendMessage(message);
      setState(() {
        _messages.add(ChatBubble(
          message: response,
          isSentByUser: false,
        ));
      });
    } catch (e) {
      print('Error sending message: $e');
      setState(() {
        _messages.add(const ChatBubble(
          message: 'Error: Could not get response from OpenAI',
          isSentByUser: false,
        ));
      });
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with AI'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                      _controller.clear();
                      setState(() {

                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



