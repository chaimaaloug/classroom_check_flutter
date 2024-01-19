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
    // Récupérer l'instance de SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Enregistrer l'e-mail et le codepin dans les préférences partagées
    await prefs.setString('email', _emailController.text);
    await prefs.setString('pin', _pinController.text);

    // Afficher une popup pour informer l'utilisateur de la réussite de son inscription
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Connexion'),
          content: const Text('Vous êtes bien inscrit.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
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
        title: const Text('Me connecter', style: TextStyle(fontSize: 23)),
        backgroundColor: Colors.amber.shade500,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/login.png',
                width: 650,
                height: 290,
              ),
              const SizedBox(height: 28),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 34),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _pinController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: 'PIN',
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 34),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              ElevatedButton(
                onPressed: _savePinCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 34),
                ),
                child: const Text(
                  'Enregistrer',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
