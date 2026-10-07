import 'dart:async';

import 'package:flutter/material.dart';

import 'login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key, required this.title});

  final String title;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginView(title: 'Login'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/pantrymatch_logo.png', width: 300),
      ),
    );
  }
}
