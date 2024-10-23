import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:summer_proj_app/preferenceUtils.dart'; 
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  bool _generateFlashcard = false;  // Add this to _ChatScreenState




  Future fetchData(String userBody) async {
    final response = await http.post(Uri.parse('http://127.0.0.1:8000/summarize/'), body: userBody);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      return response.body;
    }
    
     else 
     {
      // If the server did not return a 200 OK response, throw an exception.
      return 'Failed to load data. Try again';
    }
  }



  void _handleSubmitted(String text) async {
  print("skibid'");
  
  // Check if the checkbox is checked
  
  
  String result = await fetchData(text);
  if (text.isNotEmpty) {
    _controller.clear();
    setState(() {
      _messages.add("User: $text");
      _messages.add("> $result");
    });


    if (_generateFlashcard) {
      String token = PreferenceUtils.getString("authToken");
    
    final response = await http.post(Uri.parse('http://127.0.0.1:8000/summarizeToFlashcards/'), headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', 
        },
        body: jsonEncode({
          "authToken": token, 
          "text": text,        
          "result": result,    
        }),);
    if (response.statusCode == 200) {
      
       print(response.body);
    }
    
     else 
     {
      
       print('Failed to load data. Try again');
    }
    
    return; 
  }
  }
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color.fromARGB(255,21,21,20),
      
      body: Column(
        children: <Widget>[

          TextBox(messages: _messages),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: UserInputField(controller: _controller, handleSubmitted: _handleSubmitted, generateFlashcard: _generateFlashcard,
            onGenerateFlashcardChanged:(bool? value) {
              setState(() {
                //print("Skibid changed");
                _generateFlashcard = value ?? false; 
              });
            } ,),
          ),
        ],
      ),
    );
  }
}

class TextBox extends StatelessWidget 
{

  const TextBox({
    super.key,
    required List<String> messages,
  }) : _messages = messages;

  final List<String> _messages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255,21,21,20),
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
                      child: (index % 2 == 0)  ?  SelectableText("> ${_messages[index]}" , style: DefaultTextStyle.of(context).style.copyWith(color: const Color.fromARGB(255, 99, 81, 159)) ) : Text( _messages[index] ,),
                    );
                  },
                ),
        ),
      ),
    );
  }
}



class UserInputField extends StatelessWidget {
  const UserInputField({
    super.key,
    required TextEditingController controller,
    required void Function(String) handleSubmitted,
    required bool generateFlashcard,  
    required void Function(bool?) onGenerateFlashcardChanged,  
  })  : _controller = controller,
        _handleSubmitted = handleSubmitted,
        _generateFlashcard = generateFlashcard,
        _onGenerateFlashcardChanged = onGenerateFlashcardChanged;

  final TextEditingController _controller;
  final void Function(String) _handleSubmitted;
  final bool _generateFlashcard;
  final void Function(bool?) _onGenerateFlashcardChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            style: Theme.of(context).textTheme.labelMedium!.copyWith(height: 1.5),
            controller: _controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 21, 21, 20),
              hintText: 'Enter your message here (Enable checkbox to autogenerate summarized flashcards)',
              hintStyle: Theme.of(context).textTheme.labelMedium,
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null, 
            onSubmitted: (text) => _handleSubmitted(text),
          ),
        ),
        Checkbox(
          value: _generateFlashcard,  
          onChanged: _onGenerateFlashcardChanged,  
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () => _handleSubmitted(_controller.text),
        ),
      ],
    );
  }
}
