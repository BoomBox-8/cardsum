import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:summer_proj_app/preferenceUtils.dart';


//funky functions for DB wala stuff goes here



Future <String> getUsername() async
{
  String token = PreferenceUtils.getString("authToken");
  String body = jsonEncode({"authToken" : token});

  final response =  await http.post(Uri.parse("http://127.0.0.1:8000/getUserInfo/"), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',  // Optional for access token if needed
    },
    body: body,
  );

  if (response.statusCode == 401)
  {
    return "Logged Out";
  }

  return jsonDecode(response.body)["username"];
}


Future<void> createFlashcard(String topic, String title, String text) async {
  final url = Uri.parse('http://127.0.0.1:8000/registerFlashcard/');
  String token = PreferenceUtils.getString("authToken");


  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      "authToken" : token,
      'topic': topic,
      'title': title,
      'text': text,

    }),
  );

  if (response.statusCode == 201) {
    print('Flashcard created successfully');
  } else {
    print('Failed to create flashcard: ${response.body}');
  }
}