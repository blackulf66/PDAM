import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:pdamfinal/bloc/post/postbloc/bloc/post_bloc.dart';
import 'package:pdamfinal/models/auth/me_response.dart';
import 'package:pdamfinal/models/post/post_response.dart';
import 'package:pdamfinal/models/subpost/Subpost_response.dart';
import 'package:pdamfinal/models/vote/vote_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdamfinal/repository/postRepository/post_repository.dart';
import 'package:pdamfinal/repository/postRepository/post_repository_impl.dart';
import 'package:pdamfinal/repository/voteRepository/vote_repository.dart';
import 'package:pdamfinal/repository/voteRepository/vote_repository_impl.dart';
import 'package:pdamfinal/ui/screens/ErrorPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/post/blocpostsubostid/postsubpostid_bloc.dart';
import '../../constants.dart';
import 'menu_screen.dart';

class ComunitycreenFollowing extends StatefulWidget {
  ComunitycreenFollowing({Key? key}) : super(key: key);
  @override
  _ComunitycreenState createState() => _ComunitycreenState();
}
class _ComunitycreenState extends State<ComunitycreenFollowing> {

    late VoteRepository voteRepository;

      late Future<SharedPreferences> _prefs;

    late PostApiRepository postApiRepository;

    @override
    void initState() {
    super.initState();
    voteRepository = VoteRepositoryImpl();
    postApiRepository = PostApiRepositoryImpl();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        

    return MultiBlocProvider(
        providers: [
          BlocProvider<PostSubPostIdBloc>(
      create: (context) => PostSubPostIdBloc(postApiRepository)..add(FetchPostSubPostId()),
    ),
        ],
        child: _principalScreen(),
      );
    }

    Widget _principalScreen(){
                final subpost = ModalRoute.of(context)!.settings.arguments as Following;
      return Scaffold(
        appBar: AppBar(
            title: Text("Detalle de comunidad"),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent),
        body: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom:20.0),
              child: Image(image: NetworkImage(subpost.imagen)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(subpost.nombre , style: TextStyle(color:Colors.white , fontSize: 25),)),
            ),
      
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(subpost.descripcion , style: TextStyle(color:Colors.white , fontSize: 15),)),
            ),
      
        
      
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text("publicada en: "+subpost.createdDate, style: TextStyle(color:Colors.white , fontSize: 15),)),
            ),
      
            //_createPostList(context , subpost.id)
      
      
      
      
          ],
        ),
      )
    ));
    }

Widget _createPostList(BuildContext context , int postId) {
    return BlocBuilder<PostSubPostIdBloc, postsubpostidState>(
      builder: (context, state) {
        if (state is BlocpostsubpostidInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is postsubpostidFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<PostSubPostIdBloc>().add(FetchPostSubPostId2(postId));
            },
          );
        } else if (state is postsubpostidFetched) {
          return _PostList(context, state.post);
        } else {
          return const Text('Not support');
        }
      },
    );
  }
 Widget _PostList(BuildContext context, List<PostApiResponse> post){
    return  SingleChildScrollView(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics() ,
                itemBuilder: (BuildContext context, int index){
                  return _Post(context , post[index] ) ;                         
                },
                itemCount: post.length,
              ),
            ],
          ),  
        
        
      ),
    );
  }


 Widget _Post(BuildContext context,PostApiResponse post){
    
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
                Padding(
                  padding: const EdgeInsets.only(right: 400),
                  child: Container(
                    child:  Text( 
                          post.subpostsName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Style.LetraColor
                          ),
                        ),
                  ),
                ),
                Container(
                  child: Row(              
                    children: <Widget>[
        
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text( 
                          post.postName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Color.fromARGB(255, 255, 255, 255)
                          ),
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
            Navigator.pushNamed(context,'/detailpage' ,arguments: post);
          },
                  child: SizedBox(
                    width:  MediaQuery.of(context).size.width,
                    height:300,
                    child: Image(
                      image: NetworkImage( post.imagenportada ),
                          
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
                            onTap: () async {
                              final VoteDto voteDto = VoteDto(voteType: 'LIKE', postId: post.postId);

                              voteRepository.fetchVote(voteDto);

                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.check , color: Style.LetraColor,),
                            ),
                          ),
              
                           
                             
                              Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text(post.voteCount.toString(), style: TextStyle(color:Colors.white),),
                             ),
                           
                           
                           InkWell(
                              onTap: (){

                                final VoteDto voteDto = VoteDto(voteType: 'DISLIKE', postId: post.postId);

                                 voteRepository.fetchVote(voteDto);

                              },
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

