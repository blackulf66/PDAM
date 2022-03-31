import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';

import '../../constants.dart';
import 'post_model.dart';
import 'posts_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   PostProvider postProvider = new PostProvider();   
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),  
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: _comunityList()
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _parteabajo(),                
            Divider(color: Colors.grey, thickness: 0.5 , height: 0.0),
            _postsList(),
          ],
        ),          
      ),       
    );
  }

  Widget _parteabajo() {
    return Container(
      margin: EdgeInsets.only( top: 5.0, left: 14.0, right: 14.0 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       
      ),
    );
  }

  Widget _postsList(){

    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics() ,
        itemCount: postProvider.getPosts().length,
        itemBuilder: (context , i){
          return _Post( postProvider.getPosts()[i] ) ;                         
        },
      ),  
    );
  }

  Widget _comunityList(){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics() ,
        itemCount: postProvider.getPosts().length,
        itemBuilder: (context , i){
          return _Post2( postProvider.getPosts()[i] ) ;                         
        },
      ),  
    );
  }

  Widget _Post2(Post post ){

    List<Widget> userLikes = [];
    userLikes.add( Text('le gusta a') );

    int count = 1;
    int qtyUserLikes = post.topsLikes.length;

    post.topsLikes.forEach(( user ) {
      Widget _temp = Text( 
        count != qtyUserLikes ? user + "," : user,
        style: TextStyle( 
          fontWeight:  FontWeight.bold
        ),  
      );
      userLikes.add(_temp);
      count == qtyUserLikes ? userLikes.add(Text(' y ')) : null ;
      count == qtyUserLikes ? userLikes.add(Text('${post.likes} personas mas', style: TextStyle( fontWeight: FontWeight.bold , fontSize: 18.0))) : null ;
      count++;
    });


    return Row(
      children: [
          ClipRRect(
                          borderRadius:BorderRadius.circular(50.0),
                          child: Image(
                            image: NetworkImage( post.userPhoto ),
                            height: 45.0,
                            width: 45.0,
                          ),
                        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(post.userName , style: TextStyle(color: Style.LetraColor
),),
        ),
      

      ],
    );
}

  Widget _Post(Post post ){

    List<Widget> userLikes = [];
    userLikes.add( Text('le gusta a') );

    int count = 1;
    int qtyUserLikes = post.topsLikes.length;

    post.topsLikes.forEach(( user ) {
      Widget _temp = Text( 
        count != qtyUserLikes ? user + "," : user,
        style: TextStyle( 
          fontWeight:  FontWeight.bold
        ),  
      );
      userLikes.add(_temp);
      count == qtyUserLikes ? userLikes.add(Text(' y ')) : null ;
      count == qtyUserLikes ? userLikes.add(Text('${post.likes} personas mas', style: TextStyle( fontWeight: FontWeight.bold , fontSize: 18.0))) : null ;
      count++;
    });


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.black,
        
       
          child: Container(
             decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(              
                    children: <Widget>[
        
                      Container(
                        padding: EdgeInsets.only(top: 12.0 , left: 18.0, bottom: 12.0, right: 12.0 ),
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(50.0),
                          child: Image(
                            image: NetworkImage( post.userPhoto ),
                            height: 45.0,
                            width: 45.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width:130,
                      ),
        
                      Text( 
                        post.userName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Style.LetraColor
                        ),
                      ),
                      Expanded(child: SizedBox()),
        
                          
                    ],
                  ),
                ),
        
                InkWell(
          splashColor: Colors.purple,
          onTap: (){
            
          },
                  child: SizedBox(
                    width:  MediaQuery.of(context).size.width,
                    height:300,
                    child: Image(
                      image: NetworkImage( post.postPhoto ),
                          
                    ),
                  ),
                ),
        
                Container( 
                  padding: EdgeInsets.only(top:5.0, left: 7.0, right: 7.0, bottom: 0.0),
                  child: 
                      Row(
                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap: (){},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.check , color: Style.LetraColor,),
                            ),
                          ),
              
                           InkWell(
                              onTap: (){},
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Icon(Typicons.comment, color: Style.LetraColor,),
                             ),
                           ),
                           
                           InkWell(
                              onTap: (){},
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Icon(Typicons.cancel, color: Style.LetraColor,),
                             ),
                           ),
                        ],
                      ),
                ),
                
               
                  
                            
              ],
            ),
          ),
        ),
      
    );
    

  }


}