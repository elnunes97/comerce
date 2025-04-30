
import 'package:comerce/views/home/home_page.dart';
import 'package:comerce/views/auth/login_page.dart';
import 'package:comerce/views/auth/register_page.dart';
import 'package:comerce/views/produtos/cadastrar.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'views/produtos/ProdutosPage.dart';

import 'views/auth/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
      ),
      themeMode: ThemeMode.system,
      home: const SplashScreen(), // <<<< Aqui

      routes: {
        '/home': (context) =>  HomePage(), // <<<< Aqui
        // Adicione outras rotas conforme necessário
        '/login': (context) => const LoginPage(), // <<<< Aqui
        '/register': (context) => const RegisterPage(), // <<<< Aqui
        '/produtos' : (context) => const ListarProdutosPage(),
        '/cadastrar' : (context) => CadastrarProdutoPage(),
      },
    );
  }
}
