import 'package:prj_flutter/views/students_screen.dart';
import 'package:prj_flutter/views/login_screen.dart';
import 'package:prj_flutter/views/qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:prj_flutter/views/signature_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QRScreen(),
      //home: SignatureScreen()
      //home: LoginScreen(),
      //home: StudentsListScreen(),
    );
  }
}
