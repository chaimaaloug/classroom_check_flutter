import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  bool _isObscure = true;

  Future<void> _savePinCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailController.text);
    await prefs.setString('pin', _pinController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Me connecter', style: TextStyle(fontSize: 23)),
        backgroundColor: Colors.amber.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/login.png',
              width: 600,
              height: 260,
            ),
            SizedBox(height: 28),
            Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey.shade400,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 34),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                TextFormField(
                  controller: _pinController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    labelText: 'PIN',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.grey.shade400,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey.shade400),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 34),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 26),
            SizedBox(
              child: ElevatedButton(
                onPressed: () async {
                  await _savePinCode();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 34),
                ),
                child: const Text(
                  'Enregistrer',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
