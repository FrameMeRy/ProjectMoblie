import 'package:flutter/material.dart';
import 'package:pj/srceens/cart.dart';
import 'package:pj/srceens/receipt.dart';
import 'package:pj/srceens/success.dart';
import 'srceens/home.dart';
import 'srceens/login.dart';
import 'srceens/add_user.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User CRUD',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/login': (context) => const Login(),
        '/add_user': (context) => const UserForm(),
        '/cart': (context) => const Cartpage(),
        '/receipt': (context) => const Receipt(),
        '/success': (context) => const Successpage(),
      },
    );
  }
}
