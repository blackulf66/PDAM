import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:pdamfinal/ui/screens/ErrorPage.dart';

import '../../bloc/subpost/bloc/subpost_bloc.dart';
import '../../constants.dart';
import '../../models/subpost/Subpost_response.dart';
import 'post_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),  
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: InkWell(
          child: _createComunityList(context) ,onTap: (){
        Navigator.pushNamed(context, '/comunity');
      },)
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
          return _SubPost(postProvider.getPosts()[i] ) ;                         
        },
      ),  
    );
  }

  Widget _createComunityList(BuildContext context) {
    return BlocBuilder<SubPostBloc, SubPostState>(
      builder: (context, state) {
        if (state is BlocSubPostInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SubPostFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<SubPostBloc>().add(FetchSubPost());
            },
          );
        } else if (state is SubPostFetched) {
          return _comunityList(context, state.post);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _comunityList(BuildContext context, List<SubPostApiResponse> post){
    return  Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('mis comunidades' ,style: TextStyle(color: Style.VKNGGron),),
            ),
            Divider(color: Colors.grey,),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics() ,
              itemBuilder: (BuildContext context, int index){
                return _subPostItem(context , post[index] ) ;                         
              },
            ),
          ],
        ),  
      
      
    );
  }

  Widget _subPostItem(BuildContext context, SubPostApiResponse subpost){
    return Row(
      children: [
        
          ClipRRect(
                          borderRadius:BorderRadius.circular(50.0),
                          child: Image(
                            image: NetworkImage(subpost.imagen ),
                            height: 45.0,
                            width: 45.0,
                          ),
                        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(subpost.nombre , style: TextStyle(color: Style.LetraColor
),),
        ),
      

      ],
    );
}

  Widget _SubPost(Post post ){
    
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
                            image: NetworkImage(post.userPhoto ),
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
          onTap: (
            
            
          ){
            Navigator.pushNamed(context,'/detailpage');
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