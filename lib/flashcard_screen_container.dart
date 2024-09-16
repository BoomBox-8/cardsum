import 'package:flutter/material.dart';
import 'package:summer_proj_app/flashcardsPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:summer_proj_app/preferenceUtils.dart'; 

class FlashcardScreenContainer extends StatefulWidget {
  

   FlashcardScreenContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<FlashcardScreenContainer> createState() => _FlashcardScreenContainerState();
}

class _FlashcardScreenContainerState extends State<FlashcardScreenContainer> {
  int index = 0;


  Future<List<Map<String, dynamic>>> fetchFlashcard() async {

  String token = PreferenceUtils.getString("authToken");
  final url = Uri.parse('http://127.0.0.1:8000/getFlashcard/');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },

    body: jsonEncode({
      "authToken" : token,
      "flashcardIndex" : index
      

    })
    
  );
  

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> flashcardsData = data['flashcards'];
      print(flashcardsData);
      return List<Map<String, dynamic>>.from(flashcardsData);
    } else {
      throw Exception('Failed to load flashcards');
    }
  }


  void updateIndex(int inc)
  {
    setState(() {
      index  += inc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                            onPressed: ()=>print("Placeholder"),
        
                            style: ElevatedButton.styleFrom(minimumSize: const Size(36, 45), backgroundColor: const Color.fromARGB(255, 81, 81, 163), padding: const EdgeInsets.all(12)),
                            child: Text('Delete Flashcard', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: const Color.fromARGB(255, 221,219,255), height: 1.3, fontSize: 20), textAlign: TextAlign.center,),
                          ),
      
              const SizedBox(height: 180),          
              IconButton.filled(onPressed: () {
                updateIndex(-1);
                print(index);
                } , icon: const Icon(Icons.arrow_back_rounded)),
            ],
          ),
      
          const SizedBox(width: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
      
      
            children: [
              Container(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchFlashcard(), //i suffer






        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());



          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));

            
          } 
          
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No flashcards found'));
          }
          
          
           else {
            final flashcard = snapshot.data![0];
            return FlashcardScreen(title: flashcard['title'], topic: flashcard['topic'], text: flashcard['text']);
          }
        },
      ),
    ),
      
              const SizedBox(height: 30),
      
              ElevatedButton(
                            onPressed: ()=>print("Placeholder"),
        
                            style: ElevatedButton.styleFrom(minimumSize: const Size(36, 45), backgroundColor: const Color.fromARGB(255, 81, 81, 163), padding: const EdgeInsets.all(12)),
                            child: Text('Regenerate Text', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: const Color.fromARGB(255, 221,219,255), height: 1.3, fontSize: 20), textAlign: TextAlign.center,),
                          ),
            ],
          ),
        
        const SizedBox(width: 30),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [ElevatedButton(
                            onPressed: ()=>print("Placeholder"),
        
                            style: ElevatedButton.styleFrom(minimumSize: const Size(36, 45), backgroundColor: const Color.fromARGB(255, 81, 81, 163), padding: const EdgeInsets.all(12)),
                            child: Text('Edit Flashcard', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: const Color.fromARGB(255, 221,219,255), height: 1.3, fontSize: 20), textAlign: TextAlign.center,),
                          ),
      
              const SizedBox(height: 180),   
            IconButton.filled(onPressed: () {
                updateIndex(1);
                print(index);
                } , icon: const Icon(Icons.arrow_forward_rounded)),
          ],
        ),
      
          const SizedBox(width: 30),],
      ),
    );
  }
}