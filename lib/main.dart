import 'package:flutter/material.dart';
import 'package:morfix/screens/webview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Morfix',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const WebViewScreen(),
    );
  }
}
