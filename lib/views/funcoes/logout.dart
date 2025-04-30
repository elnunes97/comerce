import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

  ///logout
  Future<void> logout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    // Após o logout, redirecionar para a tela de login
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao sair: ${e.toString()}')),
    );
  }
}

  


///fin logout