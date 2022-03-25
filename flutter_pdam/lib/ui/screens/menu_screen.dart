import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/screens/home_screen.dart';
import 'package:flutter_application_1/ui/screens/login.dart';
import 'package:flutter_application_1/ui/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;
  late Future<SharedPreferences> _prefs;


@override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    super.initState();
  }

 List<Widget> pages = [
    const HomeScreen(),
    const LoginScreen(),
    const RegisterScreen(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_currentIndex], bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    return Container(
        decoration: BoxDecoration(
            border: const Border(
          top: BorderSide(
            color: Color(0xfff1f1f1),
            width: 1.0,
          ),
        )),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Icon(Icons.home,
                  color: _currentIndex == 0
                      ? Colors.white
                      : const Color(0xff999999)),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            GestureDetector(
              child: Icon(Icons.search,
                  color: _currentIndex == 1
                      ? Colors.white
                      : const Color(0xff999999)),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            GestureDetector(
              child: Icon(Icons.person,
                  color: _currentIndex == 2
                      ? Colors.white
                      : const Color(0xff999999)),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),

            GestureDetector(
              child: Icon(Icons.search,
                  color: _currentIndex == 1
                      ? Colors.white
                      : const Color(0xff999999)),
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
          ],
        ));
  }
  Future getImage() async {
    _prefs.then((SharedPreferences prefs) {
      return prefs.getString('avatar');
    });
  }
}