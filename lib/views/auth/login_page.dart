import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'register_page.dart';
import 'package:comerce/views/home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        //const SnackBar(content: Text('Login realizado com sucesso!')),
        const SnackBar(content: Text('Loged')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro no login: $e')),
      );
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // Cancelado

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      ScaffoldMessenger.of(context).showSnackBar(
        //const SnackBar(content: Text('Login com Google realizado com sucesso!')),
        const SnackBar(content: Text('loged')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro no login Google: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                const Text(
                  'MyShop',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 48),

                // Campo E-mail
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),

                // Campo Senha
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 24),

                // Botão Entrar
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _signInWithEmailAndPassword(context),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                      color: Colors.white),
                      
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // OU
                const Text('ou', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 16),

                // Botão Google
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    icon: Image.asset(
                      'assets/google_logo.png', // Certifique-se que esse asset existe
                      height: 24,
                    ),
                    label: const Text(
                      'Continuar com Google',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.redAccent),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () => _signInWithGoogle(context),
                  ),
                ),
                const SizedBox(height: 16),

                // Link Registrar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Não tem uma conta?',
                      style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterPage()),
                        );
                      },
                      child: const Text('Registrar',
                        style: TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
