import 'package:flutter/material.dart';
import 'package:qr_bar_code/qr/qr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: QRCodeView(data: "https://datadirr.com",)),
      ),
    );
  }
}

