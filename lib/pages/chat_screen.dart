
// import 'package:ev_homes_crm_v7/pages/AnimatedGradientScreen.dart';
import 'package:ev_homes_customer/pages/AnimatedGradientScreen.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messages = ["Hello!", "How can I help you today?"];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Chat'),
      ),
      body: Stack(
        children: [
          AnimatedGradient(),
          SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return _buildChatBubble(messages[index]);
                    },
                  ),
                ),
                _buildInputArea(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String message) {
    bool isSentByUser = message != messages.first;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
      child: Align(
        alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: isSentByUser
                ? Colors.white.withAlpha(120)
                : Colors.white.withAlpha(120),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            message,
            style: TextStyle(
              color: isSentByUser ? Colors.black : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 100),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                if (_controller.text.trim().isNotEmpty) {
                  messages.insert(0, _controller.text.trim());
                  _controller.clear();
                }
              });
            },
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.send,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
