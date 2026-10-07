import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'register_view.dart';
import 'main_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.title});

  final String title;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainView(title: 'PantryMatch'),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var titleStyle = const TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 28,
      color: Color(0xFF3A3226),
    );

    var textStyle = const TextStyle(fontSize: 13, color: Color(0xFF8A7F6B));

    buildTextField(controller, isObscure, labelText) => TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE4D9C3)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EC),
      body: Center(
        child: SizedBox(
          width: 320,
          child: Column(
            spacing: 15,
            mainAxisAlignment: .center,
            children: [
              Image.asset('assets/images/pantrymatch_logo.png', width: 210),

              Text('Welcome Back!', style: titleStyle),

              Text(
                'Log in to discover recipes from what you have.',
                style: textStyle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              buildTextField(_emailController, false, 'Email'),

              buildTextField(_passwordController, true, 'Password'),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password?',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFB5502E),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8813A),
                  foregroundColor: Colors.white,
                  fixedSize: const Size(320, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Log In'),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: textStyle),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const RegisterView(title: 'Register'),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Color(0xFF639922)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
