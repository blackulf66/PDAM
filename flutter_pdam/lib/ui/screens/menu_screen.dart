
import 'package:flutter/material.dart';
import 'package:pdamfinal/constants.dart';
import 'package:pdamfinal/ui/screens/addform_screen.dart';
import 'package:pdamfinal/ui/screens/profile_screen.dart';
import 'package:pdamfinal/ui/screens/profile_screens.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'login.dart';
import 'register_screen.dart';
import 'search_screen.dart';

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
     SearchScreen(),
     formScreen(),//postScreen
     MyApp(),//ProfileScreen
    
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
              child: Icon(Icons.home,size: 35,
                  color: _currentIndex == 0
                      ? Style.VKNGGron
                      : const Color(0xff999999)),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            GestureDetector(
              child: Icon(Icons.search,size:35,
                  color: _currentIndex == 1
                      ? Style.VKNGGron
                      : const Color(0xff999999)),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            GestureDetector(
              child: Icon(Icons.add,size: 35,
                  color: _currentIndex == 2
                      ? Style.VKNGGron
                      : const Color(0xff999999)),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),

            GestureDetector(
              child: Icon(Icons.person,size: 35,
                  color: _currentIndex == 3
                      ? Style.VKNGGron
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