import 'package:flutter/material.dart';
import '../constants.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByUser;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isSentByUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(32),
              topRight: const Radius.circular(32),
              bottomLeft: isSentByUser ? const Radius.circular(32) : Radius.zero,
              bottomRight: isSentByUser ? Radius.zero : const Radius.circular(32),
            ),
            color: isSentByUser ? KeyPrimaryColor : const Color(0xff303030),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
