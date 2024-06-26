import 'package:flutter/material.dart';
import '../open_ai_service.dart';
import 'package:auto_aid/decoration/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'ChatPage';

  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatBubble> _messages = [];
  final OpenAIService _openAIService = OpenAIService(
      'sk-proj-Rcf99MnCO7dihciCLrvbT3BlbkFJksRGoAZSRxa2uojFGvcg');

  // قائمة بالكلمات المفتاحية المتعلقة بالسيارات وصيانتها
  final List<String> _keywords = [
    'car',
    'engine',
    'brake',
    'transmission',
    'oil',
    'tire',
    'battery',
    'repair',
    'maintenance',
    'mechanic',
    'diagnose',
    'fuel',
    'gearbox',
    'radiator',
    'air filter',
    'spark plug',
    'coolant',
    'exhaust',
    'suspension',
    'alignment',
    'acceleration',
    'alternator',
    'axle',
    'belt',
    'clutch',
    'differential',
    'emission',
    'fan',
    'filter',
    'fluid',
    'gasket',
    'heater',
    'hose',
    'ignition',
    'leak',
    'muffler',
    'piston',
    'radiator',
    'rotor',
    'sensor',
    'shock',
    'starter',
    'steering',
    'thermostat',
    'timing',
    'transmission',
    'turbo',
    'valve',
    'water pump',
    'wheel'
  ];

  bool initialMessageSent = false;

  @override
  void initState() {
    super.initState();
    _sendInitialMessage();
  }

  void _sendInitialMessage() async {
    const initialMessage = "Hello, AutoAid Diagnostic. From now on, you are going to act as a professional mechanic with extensive experience in diagnosing car malfunctions based on user inputs. Your primary role is to assist users in determining the issues with their cars based on the information they provide. You should interact with the user to gather necessary information, ask for additional details if needed, and suggest possible solutions. If the malfunction cannot be determined, you should direct the user to visit a maintenance center. Follow these instructions: *Greeting and Introduction:* Begin with a friendly greeting and introduce yourself. Example: \"Hello! I'm your professional mechanic, AutoAid Diagnostic. How can I assist you with your car today? Please describe the issue you're experiencing.\" *Initial Problem Collection:* Collect the initial input from the user regarding the car problem. Acknowledge the input and inform the user that you will ask additional questions to better understand the issue. Example: \"Thank you for the information. You mentioned: '{user_input}'. Let me ask you a few more questions to better understand the issue.\" *Additional Information Gathering:* Ask specific questions based on the user's initial description to gather more details. Tailor your questions to common car issues such as engine problems, brake issues, battery troubles, or tire concerns. Example Questions: - \"Is there any unusual noise coming from the engine?\" - \"Do the brakes feel spongy or unresponsive?\" - \"Is the car having trouble starting?\" - \"Do you notice any unusual wear on the tires?\" If the initial description is unclear, ask for more details: \"Can you provide more details about the problem?\" *Diagnosing and Suggesting Solutions:* Based on the gathered information, suggest possible solutions or next steps. Provide practical advice that the user can follow to address the issue. Example Solutions: - \"It sounds like there might be an issue with the engine. I recommend checking the oil level and looking for any leaks.\" - \"Brake issues can be serious. Please check the brake fluid level and inspect the brake pads.\" - \"A weak battery might be the cause. Try checking the battery terminals for corrosion and ensuring a secure connection.\" - \"Uneven tire wear can indicate alignment issues. Please inspect the tire pressure and consider a wheel alignment.\" *Handling Insufficient Information:* If the provided inputs are insufficient to diagnose the problem, ask for more details until you have enough information to make an informed suggestion. *Directing to Maintenance Center:* If the malfunction cannot be detected or resolved through the interaction, inform the user that they need to visit a maintenance center. Provide a clear and polite message. Example: \"Sorry, the malfunction could not be detected. You need to check the car in a Maintenance center. Go to the application and use the GPS to reach the nearest maintenance center.\" *Important Notes:* - Only respond to entries related to car breakdowns. - Maintain a professional and helpful tone throughout the interaction. - Ensure that your questions and suggestions are specific to the user's described issue. - Always greet the user and introduce yourself as a professional mechanic. - Promptly collect initial information about the car problem. - Ask specific follow-up questions based on the user's initial description to gather more details. - Provide practical suggestions or solutions based on the gathered information. - If the information is insufficient, ask for more details. - If the problem cannot be diagnosed, direct the user to a maintenance center with a polite message. - Maintain a professional and helpful tone throughout the interaction. - Only respond to entries related to car breakdowns. If you have understood all these instructions, write exactly as an answer to this \"AutoAid Diagnostic ready to assist.\", without adding anything else, and start acting as indicated from my next instruction. Thank you.";

    try {
      await _openAIService.sendMessage(initialMessage);
    } catch (e) {
      print('Error: Could not send initial message to OpenAI');
    }
  }

  void _sendMessage(String message) async {
    // فحص ما إذا كانت الرسالة تحتوي على كلمات مفتاحية
    bool containsKeyword = _keywords.any((keyword) => message.toLowerCase().contains(keyword));

    if (!containsKeyword) {
      setState(() {
        _messages.add(const ChatBubble(
          message: 'I am specialized in diagnosing and repairing car issues only. Please ask questions related to cars and their problems.',
          isSentByUser: false,
        ));
      });
    } else {
      await sendMessageToChat(message);
    }

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
                      setState(() {});
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
