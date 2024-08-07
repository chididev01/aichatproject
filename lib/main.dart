import 'package:flutter/material.dart';

void main() => runApp(AIChatbotApp());

class AIChatbotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Chatbot Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatbotScreen(),
      debugShowCheckedModeBanner: false, // Disable debug banner
    );
  }
}

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  final Map<String, String> _predefinedResponses = {
    "What's your name?": "My name is Chidi James.",
    "What's your MAT number?": "My MAT number is H2023/07805/1/CS.",
    "What is this app about?": "This is an AI Chatbot demonstration app.",
    "How does the chatbot work?": "The chatbot provides predefined responses to common questions.",
    "Who developed this app?": "This app was developed by Chidi James for a school project.",
  };

  void _sendMessage() {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "text": _controller.text});
      String response = _predefinedResponses[_controller.text] ??
          "I don't have an answer for that question.";
      _messages.add({"sender": "bot", "text": response});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              'https://www.myschoolgist.com/wp-content/uploads/2018/12/abia-state-polytechnic.jpg',
              height: 50,
              width: 50,
            ),
            SizedBox(width: 10),
            Text('AI Chatbot Project'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Align(
                    alignment: _messages[index]['sender'] == 'user'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: _messages[index]['sender'] == 'user'
                          ? Colors.blue[100]
                          : Colors.grey[300],
                      child: Text(_messages[index]['text']!),
                    ),
                  ),
                );
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
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
