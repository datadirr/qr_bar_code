import 'package:flutter/material.dart';
import 'package:qr_bar_code/barcode/barcode.dart';

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
        body: SafeArea(child: Padding(
          padding: const EdgeInsets.all(20),
          child: BarcodeWidget(data: "ronak", barcode: Barcode.dataMatrix()),
        )),
      ),
    );
  }
}

