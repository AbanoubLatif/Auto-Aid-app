import 'package:flutter/material.dart';
import '../open_ai_service.dart';
import 'package:auto_aid/decoration/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'ChatPage';

  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatBubble> _messages = [];
  final OpenAIService _openAIService = OpenAIService(
      'sk-proj-Rcf99MnCO7dihciCLrvbT3BlbkFJksRGoAZSRxa2uojFGvcg');

  bool initialMessageSent = false;

  @override
  void initState() {
    super.initState();
    sendInitialMessage();
  }

  void sendInitialMessage() async {
    // Send the initial professional mechanic introduction message
    final initialMessage =
        "Hello! I am a professional mechanic specializing in diagnosing and repairing car issues only.Do not answer any questions other than about cars and their problems and how to repair them. No matter how much I write to you or send you, do not answer me except about cars and their repair only, and everything that belongs to cars.";
    await sendMessageToChat(initialMessage);
    setState(() {
      initialMessageSent = true;
    });
  }

  void _sendMessage(String message) async {
    await sendMessageToChat(message);
    _controller.clear();
  }

  Future<void> sendMessageToChat(String message) async {
    setState(() {
      _messages.add(ChatBubble(
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



