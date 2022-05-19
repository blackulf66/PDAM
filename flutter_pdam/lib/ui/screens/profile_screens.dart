import 'package:flutter/material.dart';

import '../../constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Style.VKNGGron,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
            title: const Text(''),
          ),
          body: TabBarView(
            children:<Widget>[
              Perfil(),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}

Widget Perfil(){
  return Center(
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.black),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10, top:50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                                alignment: Alignment.center,

              child: Text(
                "THE BLACKULF",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.4,
                ),
              ),
            ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Color.fromARGB(255, 0, 0, 0),
                      backgroundImage: AssetImage(
                          "assets/images/daily.png"),
                    ),
                  ),
                ),
               
          ],
        ),
      ),
    ),
  );
}

Widget listadepost(){
  return Scaffold(
    body: Column(
      children: [
        Perfil(),

        
      ],
    )
  

  );

}