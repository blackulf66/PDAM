import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';

import '../../constants.dart';

class Comunitycreen extends StatefulWidget {
  Comunitycreen({Key? key}) : super(key: key);

  @override
  _ComunitycreenState createState() => _ComunitycreenState();
}

class _ComunitycreenState extends State<Comunitycreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Detalle de comunidad"),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.black,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 90,
                                height: 90,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image(
                                    image: NetworkImage(''),
                                    height: 45.0,
                                    width: 45.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'post.userName',
                                  style: TextStyle(color: Style.LetraColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:80.0),
                          child: Center(child:Text('lista de posts',style: TextStyle(color: Style.LetraColor))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:50.0),
                          child: Container(
                            child:
                                Text(
                                  'titulo',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                      color: Style.LetraColor),
                                ),
                            ),
                          ),
                        InkWell(
                          splashColor: Colors.purple,
                          onTap: () {
                            Navigator.pushNamed(context, '/detailpage');
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            child: Image(
                              image: NetworkImage('post.postPhoto'),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 5.0, left: 7.0, right: 7.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ),
          ],
        ));
  }
}
