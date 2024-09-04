import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:summer_proj_app/preferenceUtils.dart';
import 'dart:convert';

import 'loginPage.dart';

import 'homepage.dart';
import 'toolPage.dart';
//this little fella makes sure JWT tokens are safely tucked away! local storage too!


void main() async
{
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await PreferenceUtils.init(); // Initialize PreferenceUtils

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SecondPage(), //stupid naming, should be homepage really

      theme: ThemeData(
        textTheme: const TextTheme(
          
        headlineMedium: TextStyle(
          color: Colors.white,
          fontSize: 48, 
          fontWeight: FontWeight.w700, 
          fontFamily: 'Raleway'),
        
        
        bodyMedium: TextStyle(
            color: Colors.white,
            fontFamily: 'Raleway',
            fontSize: 20,),

        labelMedium: TextStyle(
            color: Color.fromARGB(255, 99, 81, 159),
            height: 0.7,
            fontWeight: FontWeight.w500,
            fontFamily: 'Raleway',
            fontSize: 18,)


            
      ),
    ));
  }
}

