import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat UI',
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      _controller.clear();
      setState(() {
        _messages.add(text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color.fromARGB(255,21,21,20),
      
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255,21,21,20),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12.0),
                ),


                child: _messages.isEmpty
                    ? Center(
                        child: Text(
                          'Nothing here yet! Get typing!',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      )
                    : ListView.builder(
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 32, top: 16),
                            child: Text("> " + _messages[index]),
                          );
                        },
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    style: Theme.of(context).textTheme.labelMedium,
                    
                    controller: _controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255,21,21,20),
                      
                    
                      hintText: 'Enter your message here',
                      hintStyle: Theme.of(context).textTheme.labelMedium,
                      border: OutlineInputBorder(borderRadius : const BorderRadius.all(Radius.circular(12.0))),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null, // Allows the input field to be scrollable
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
