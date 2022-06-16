import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:pdamfinal/models/auth/me_response.dart';
import 'package:pdamfinal/models/post/post_response.dart';
import 'package:pdamfinal/models/subpost/Subpost_response.dart';

import '../../constants.dart';
class detailsPagePostList extends StatefulWidget {
    
    detailsPagePostList({ Key? key }) : super(key: key);

    @override
    _detailsPageState createState() => _detailsPageState();
}

class _detailsPageState extends State<detailsPagePostList> {

    
    @override
    Widget build(BuildContext context) {
      final post = ModalRoute.of(context)!.settings.arguments as PostListSU;
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
                child: Text("publicada en: "+post.createdDate, style: TextStyle(color:Colors.white , fontSize: 15),)),
            )
      
      
      
      
          ],
        ),
      )
    );
    }
}