import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SignatureScreen extends StatefulWidget {
  final String? studentId;
  final String? sessionId;
  final String? pinCode;

  const SignatureScreen({
    this.studentId,
    this.sessionId,
    this.pinCode,
  });

  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final Dio _dio = Dio();

  Future<void> _signPresence() async {
    try {
      final data = {
        if (widget.studentId != null) 'studentId': widget.studentId,
        if (widget.sessionId != null) 'sessionId': widget.sessionId,
        if (widget.pinCode != null) 'pinCode': widget.pinCode,
      };

      final response = await _dio.post(
        'https://vanpgwkqjxdekkescqpm.supabase.co/functions/v1/student_sign',
        data: data,
      );

      if (response.statusCode == 204) {
        print('Signature réussie');
      } else {
        print('Échec de la signature');
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erreur'),
              content: Text(
                  'Vous n\'avez pas les droits pour valider la présence d\'un autre utilisateur.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Erreur inattendue: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signature numérique'),
        backgroundColor: Colors.amber.shade700,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _signPresence();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 34),
          ),
          child: Text(
            'Signer la présence',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
