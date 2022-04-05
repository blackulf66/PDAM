import 'package:flutter/cupertino.dart';

 import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';

import '../../constants.dart';
class SearchScreen extends StatefulWidget {
    
    SearchScreen({ Key? key }) : super(key: key);

    @override
    _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
 Icon customIcon = const Icon(Icons.search);
 Widget customSearchBar = const Text('Busca aqui tu comunidad');
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
  appBar: AppBar(
  backgroundColor: Colors.grey,
  title: customSearchBar,
  automaticallyImplyLeading: false,
  actions: [
   IconButton(
    onPressed: () {
    setState(() {
    if (customIcon.icon == Icons.search) {
   customIcon = const Icon(Icons.cancel);
   customSearchBar = const ListTile(
   leading: Icon(
    Icons.search,
    color: Colors.white,
    size: 28,
   ),
   title: TextField(
    decoration: InputDecoration(
    hintText: 'pon aqui el nombre de la comunidad',
    hintStyle: TextStyle(
     color: Colors.white,
     fontSize: 18,
     fontStyle: FontStyle.italic,
    ),
    border: InputBorder.none,
    ),
    style: TextStyle(
    color: Colors.white,
    ),
   ),
   );
  }  else {
     customIcon = const Icon(Icons.search);
     customSearchBar = const Text('Busca aqui tu comunidad');
    }
    });
   },
   icon: customIcon,
   )
  ],
  centerTitle: true,
  ),
  //listview
  body: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(top:80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          SizedBox(
            width:100,
            height: 100,
            child: ClipRRect(
                              borderRadius:BorderRadius.circular(10.0),
                              child: Image(
                                image: NetworkImage( 'url' ),
                                height: 45.0,
                                width: 45.0,
                              ),
                            ),
          ),
          

         Text('Comunidad 1', style: TextStyle(color:Colors.white),),


         InkWell(
           child: Container(
             child: Icon(Icons.add,color: Colors.white,size: 35),
           
           ),
           onTap:(){

           }
         )
        
      ],),
    )
  ),
  );
  }
}