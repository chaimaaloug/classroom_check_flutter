import 'package:prj_flutter/views/qr_content_screen.dart';
import 'package:prj_flutter/views/students_list_screen.dart';
import 'package:prj_flutter/views/qr_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QRScreen(),
    );
  }
}
