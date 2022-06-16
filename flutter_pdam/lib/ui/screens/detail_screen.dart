 import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:pdamfinal/models/post/post_response.dart';

import '../../constants.dart';
class detailsPage extends StatefulWidget {
    
    detailsPage({ Key? key }) : super(key: key);

    @override
    _detailsPageState createState() => _detailsPageState();
}

class _detailsPageState extends State<detailsPage> {

    
    @override
    Widget build(BuildContext context) {
      final post = ModalRoute.of(context)!.settings.arguments as PostApiResponse;

                   final date = DateTime.parse(post.createdDate);

         return Scaffold(
      appBar: AppBar(
        title: Text(post.subpostsName),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom:20.0),
              child: Image(image: NetworkImage(post.imagenportada)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(post.postName , style: TextStyle(color:Colors.white , fontSize: 25),)),
            ),
      
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(post.description , style: TextStyle(color:Colors.white , fontSize: 15),)),
            ),
      
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text("votos: "+post.voteCount.toString() , style: TextStyle(color:Colors.white , fontSize: 15),)),
            ),
      
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.bottomLeft,
                child:Text(
                "creado en: " +
                    date.day.toString() +
                    "/" +
                    date.month.toString() +
                    "/" +
                    date.year.toString(),
                style: TextStyle(color: Style.LetraColor),
              ),),
            )
      
      
      
      
          ],
        ),
      )
    );
    }
}