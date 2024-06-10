import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/provider/chat_provider.dart';
import 'package:flutter_chatgpt/provider/models_provider.dart';
import 'package:flutter_chatgpt/screens/chat_screen.dart';

import 'constants/constants.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> ModelsProvider()),
         ChangeNotifierProvider(create: (_)=> ChatProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          //scaffoldBackgroundColor: scaffoldBackgroundColor,
           scaffoldBackgroundColor: const Color(0xff1F222A),
          
          appBarTheme: AppBarTheme(
            color: cardColor,
          ),
          primarySwatch: Colors.blue,
        ),
        home: const ChatScreen()
      ),
    );
  }
}

