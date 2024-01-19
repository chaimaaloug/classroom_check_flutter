import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:prj_flutter/models/students.dart';
import 'package:prj_flutter/models/student.dart';
import 'package:prj_flutter/models/session.dart';
import 'package:prj_flutter/views/login_screen.dart';

class StudentsListScreen extends StatelessWidget {
  final Students? students;
  final Session? session;

  const StudentsListScreen(
      {Key? key, required this.students, required this.session})
      : super(key: key);

  Future<void> _showSignatureDialog(
      BuildContext context, Student student) async {
    TextEditingController pinCodeController = TextEditingController();

    bool isFormSaved = (await showDialog<bool?>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Signature électronique ✍️'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      'Signature électronique pour ${student.firstName} ${student.lastName}.',
                    ),
                    SizedBox(height: 20),
                    Text('Code PIN de l\'étudiant:'),
                    TextField(
                      controller: pinCodeController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Code PIN',
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Valider'),
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        )) ??
        false;

    if (isFormSaved) {
      try {
        final dio = Dio();
        final response = await dio.post(
          'https://vanpgwkqjxdekkescqpm.supabase.co/functions/v1/student_sign',
          data: {
            "studentId": student.id,
            "sessionId": session!.id,
            "pinCode": pinCodeController.text,
          },
        );

        if (response.statusCode == 204) {
          Navigator.of(context).pop();
        } else if (response.statusCode == 403) {
          print('Erreur 403: ${response.data}');
        } else {
          print('Unexpected status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Erreur: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Élèves 👩‍🎓'),
        backgroundColor: Colors.amber.shade700,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        itemCount: students?.students.length ?? 0,
        itemBuilder: (context, index) {
          final Student student = students!.students[index];
          return GestureDetector(
            onTap: () {
              _showSignatureDialog(context, student);
            },
            child: ListTile(
              title: Text('${student.firstName} ${student.lastName}'),
              subtitle: Text('${student.email}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(student.hasSigned ? 'Présent' : 'Absent'),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}