import 'package:chatapp/pages/Chat_Page.dart';
import 'package:chatapp/pages/Register_page.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id : (context) =>LoginPage(),
        Register_page.id: (context) => Register_page(),
        ChatPage.id:(context)=>ChatPage(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute:  LoginPage.id,
    );
  }
}


