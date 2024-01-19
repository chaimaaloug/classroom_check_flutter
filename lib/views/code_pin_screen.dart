import 'package:flutter/material.dart';

class CodePinScreen extends StatefulWidget {
  @override
  _CodePinScreenState createState() => _CodePinScreenState();
}

class _CodePinScreenState extends State<CodePinScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire de Signature'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Code PIN'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
