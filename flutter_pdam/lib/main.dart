import 'package:flutter/material.dart';
import 'package:pdamfinal/ui/screens/comunity_screen.dart';
import 'package:pdamfinal/ui/screens/profile_screens.dart';
import 'ui/screens/addform_screen.dart';
import 'ui/screens/detail_screen.dart';
import 'ui/screens/login.dart';
import 'ui/screens/menu_screen.dart';
import 'ui/screens/register_screen.dart';
import 'ui/screens/search_screen.dart';

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
      initialRoute: '/login',
  routes: {
    '/': (context) => const MenuScreen(),
    '/login' : (context)  => const LoginScreen(),
    '/register': (context) => const RegisterScreen(),
    '/menu':(context) => const MenuScreen(),
    '/detailpage':(context)=> detailsPage(),
    '/search':(context)=>SearchScreen() ,
    '/perfil':(context) => ProfileScreen(),
    '/addform':(context) =>formScreen(),
    '/comunity':(context) => Comunitycreen()
    

  },
    );
  }
}