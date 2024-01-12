import 'package:flutter/material.dart';
import 'package:prj_flutter/models/students.dart';
import 'package:prj_flutter/models/student.dart';
import 'package:prj_flutter/models/session.dart';

class StudentsListScreen extends StatelessWidget {
  final Students? students;
  final Session? session;

  const StudentsListScreen(
      {Key? key, required this.students, required this.session})
      : super(key: key);

  Future<void> _showSignatureDialog(
      BuildContext context, Student student) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Signature électronique'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Signature électronique pour ${student.firstName} ${student.lastName}.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Valider'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Élèves'),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
