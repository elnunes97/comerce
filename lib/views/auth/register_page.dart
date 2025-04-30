import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>(); // chave do formulário

  bool _isLoading = false;

  // Validador de e-mail
  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
);

// Salva no Firestore
await FirebaseFirestore.instance
    .collection('users')
    .doc(userCredential.user!.uid)
    .set({
    'name': _nameController.text.trim(),
    'email': _emailController.text.trim(),
    'role': 'client', // atribuição padrão
    'createdAt': FieldValue.serverTimestamp(),
});

      

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuário registrado com sucesso")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      String errorMsg = 'Erro ao registrar';

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMsg = 'E-mail já está em uso';
            
            break;
          case 'weak-password':
            errorMsg = 'A senha é muito fraca';
            break;
          case 'invalid-email':
            errorMsg = 'E-mail inválido';
            break;
          default:
            errorMsg = e.message ?? errorMsg;
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'MyShop',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 32),

                // Nome
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? 'Informe seu nome' : null,
                ),
                const SizedBox(height: 16),

                // E-mail
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe seu e-mail';
                    } else if (!_isEmailValid(value.trim())) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Senha
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Senha deve ter ao menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Confirmar Senha
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Senha',
                    prefixIcon: Icon(Icons.lock_person_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Botão Registrar
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
                    onPressed: _isLoading ? null : _register,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Registrar',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // Link Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Já tem uma conta?',
                      style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        'Entrar',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
