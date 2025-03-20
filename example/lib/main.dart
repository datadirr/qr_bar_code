import 'package:flutter/material.dart';
import 'package:qr_bar_code/code/code.dart';
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
    return const MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              QRCode(data: "https://datadirr.com"),
              Code(data: "https://datadirr.com", codeType: CodeType.qrCode()),
            ],
          ),
        ),
      ),
    );
  }
}
