import 'package:flutter/material.dart';
import 'package:my_chat_app/utils/app_routes.dart';

import 'package:my_chat_app/views/screens/all_user_page/all_user_page.dart';
import 'package:my_chat_app/views/screens/chate_page/chate_page.dart';
import 'package:my_chat_app/views/screens/home_page/home_page.dart';
import 'package:my_chat_app/views/screens/signIN_page/signIN_page.dart';
import 'package:my_chat_app/views/screens/signUP_page/signUP_page.dart';
import 'package:my_chat_app/views/screens/splesh_page/splesh_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.splashpage: (context) => const SplashPage(),
        // Routes.loginpage: (context) => const LoginPage(),
        // Routes.creataccount: (context) => CreatAccount(),
        // Routes.otpscreen: (context) => OtpScreen(),
        Routes.signin: (context) => Sihnin(),
        Routes.signup: (context) => Signup(),
        Routes.homepage: (context) => HomePage(),
        // Routes.myfriends: (context) => MyFriends(),
        Routes.alluserspage: (context) => AllUsersPage(),
        Routes.chatpage: (context) => ChatPage(),
      },
    );
  }
}
