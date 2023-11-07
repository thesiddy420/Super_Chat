import 'dart:io';

import 'package:flutter/material.dart';
import '/screens/welcome_screen.dart';
import '/screens/login_screen.dart';
import '/screens/registration_screen.dart';
import '/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBQaScgaR_ZInvlsp6LEiWg3OqZ1Mt1uyU", 
      appId: "1:320139388138:android:159d47890a80707b83a393", 
      messagingSenderId: "320139388138", 
      projectId:  "chatting-application-e87b5"
      ),
  )
  :await Firebase.initializeApp();
  return runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes:{
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id:(context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        // ''
      },
    );
  }
}
