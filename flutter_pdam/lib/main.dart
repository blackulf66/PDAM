import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/screens/home_screen.dart';
import 'package:flutter_application_1/ui/screens/login.dart';
import 'package:flutter_application_1/ui/screens/menu_screen.dart';
import 'package:flutter_application_1/ui/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FinalPDAM',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0)
      ),
      initialRoute: '/menu',
  routes: {
    '/': (context) => const MenuScreen(),
    '/login' : (context)  => const LoginScreen(),
    '/register': (context) => const RegisterScreen(),
    '/menu':(context) => const MenuScreen()
    

  },
    );
  }
}