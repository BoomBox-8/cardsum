import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


import 'homepage.dart';
import 'flashcardsPage.dart';
import 'toolPage.dart';
import 'summarizerPage.dart';
import 'httpsTest.dart';

class PreferenceUtils {
  static SharedPreferences? _prefsInstance;

  // This method should be called once during app initialization
  static Future<void> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
  }

  static SharedPreferences get _instance {
    if (_prefsInstance == null) {
      throw StateError("SharedPreferences is not initialized. Call init() first.");
    }
    return _prefsInstance!;
  }

  static String getString(String key, [String? defValue]) {
    return _instance.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    return _instance.setString(key, value);
  }
}

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
      home: toolPage(),

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

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  bool isProvidedDetailsRight(String username, String password) {
    // Simulated backend check
    return username == 'user' && password == 'password1234';
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      if (isProvidedDetailsRight(
          _usernameController.text, _passwordController.text)) {
        setState(() {
          _errorMessage = 'Login successful!';

          //move to next page here
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondPage()));
        });
        // Navigate to the next screen or handle successful login
      } else {
        setState(() {
          _errorMessage = 'Invalid username or password.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 23, 31, ),
    
      
      
      body: Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/signInBG.png"), fit: BoxFit.cover)),
        child: Center(
          
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:256, vertical: 64),
              child: Column(
                children: [ const Text("Sign In, Turbocharge Your Learning Now.", selectionColor: Color.fromARGB(255, 255, 255, 255), style: TextStyle(color:  Color.fromARGB(255,255,255,255), fontSize: 48, fontFamily: 'Raleway', fontWeight: FontWeight.w300),),
                const SizedBox(height: 56 ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        RoundedTextFormField(
                          obscureText: false,
                          controller: _usernameController,
                          labelText: 'Username',
                          hintText: 'Enter your username here',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        RoundedTextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: 'Enter your password here',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
        
                        
                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(minimumSize: const Size(180, 40)),
                          child: const Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Raleway'),),
                        ),
                        const SizedBox(height: 20, width: 60),
                        Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red, fontFamily: 'Raleway'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class RoundedTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  const RoundedTextFormField({super.key, 
    required this.controller,
    required this.labelText,
    required this.obscureText,
    this.hintText = '',
    
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(0, 47, 33, 33),
        border: Border.all(width: 1.0, color:const Color.fromARGB(255, 163, 163, 163) ),
        borderRadius: BorderRadius.circular(12.0),
      
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white, fontFamily: 'Raleway'),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          labelStyle: const TextStyle(color: Color.fromARGB(255, 111, 111, 111), fontFamily: 'Raleway'),

          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 111, 111, 111), fontFamily: 'Raleway')
          
        ),
        validator: validator,
      ),
    );
  }
}