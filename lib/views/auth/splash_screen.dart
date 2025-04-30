import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../home/home_page.dart';
import 'login_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _verificarLogin();
  }

  void _verificarLogin() async {
    await Future.delayed(const Duration(seconds: 2)); // tempo da splash

    User? usuario = FirebaseAuth.instance.currentUser;

    if (usuario != null) {
      // Usuário logado → vá para Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Não logado → vá para Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 20),
            const Text(
              'MyShop',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
