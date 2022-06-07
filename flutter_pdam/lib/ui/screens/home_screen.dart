import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:pdamfinal/models/post/post_response.dart';
import 'package:pdamfinal/models/vote/vote_dto.dart';
import 'package:pdamfinal/repository/userRepository/user_repository.dart';
import 'package:pdamfinal/repository/voteRepository/vote_repository.dart';
import 'package:pdamfinal/repository/voteRepository/vote_repository_impl.dart';
import 'package:pdamfinal/ui/screens/ErrorPage.dart';
import 'package:pdamfinal/bloc/user/bloc3/user_bloc.dart';



import '../../bloc/postbloc/bloc/post_bloc.dart';
import '../../bloc/user/bloc/user_bloc.dart';
import '../../bloc/user/bloc3/user_bloc.dart';
import '../../constants.dart';
import '../../models/auth/me_response.dart';
import '../../repository/postRepository/post_repository.dart';
import '../../repository/postRepository/post_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/userRepository/user_repository_impl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late PostApiRepository postApiRepository;
  late UserRepository userRepository;
  late VoteRepository voteRepository;


  @override
    void initState() {
    super.initState();
    postApiRepository = PostApiRepositoryImpl();
    userRepository = UserRepositoryImpl();
    voteRepository = VoteRepositoryImpl();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
     //BlocProvider(create: (context) { return PostBloc(postApiRepository)..add(FetchPost()); },
    MultiBlocProvider(
  providers: [
    BlocProvider<PostBloc>(
      create: (context) => PostBloc(postApiRepository)..add(FetchPost()),
    ),
     BlocProvider<UserBloc3>(
      create: (context) => UserBloc3(userRepository)..add(FetchUserListFollow()),
    ),
    BlocProvider<UserBloc>(
      create: (context) => UserBloc(userRepository)..add(FetchUser()),
    ),
  ],
    child: Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),  
      drawer: Drawer(
        backgroundColor: Colors.black,
          child: _createFollowsList(context)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:20,right: 20,top:40),
              child: _createUserProfile(context),
            ),
            _createPostList(context),
          ]))));
  }
 Widget _createUserProfile(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is BlocUserInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<UserBloc>().add(FetchUser());
            },
          );
        } else if (state is UserFetched) {
          return _usermenu(context , state.user);
        } else {
          return const Text('Not support');
        }
      },
    );
  }
   Widget _usermenu(BuildContext context ,MeResponse me){
     return Container(
       
       child: Row(
         
         children: [
         CircleAvatar(
                      radius: 50,
                      backgroundColor: Color.fromARGB(255, 0, 0, 0),
                      backgroundImage: NetworkImage(
                          me.avatar),
                    ),
                    SizedBox(width:40,
                    ),
           Text(me.username , style: TextStyle(color: Colors.white , fontSize: 20),)
         ],
       )
     );
   }

  

  /*Widget _postsList(){

    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics() ,
        itemCount: postProvider.getPosts().length,
        itemBuilder: (context , i){
          return _SubPost(postProvider.getPosts()![i] ) ;                         
        },
      ),  
    );
  }*/


    Widget _createPostList(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is BlocPostInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<PostBloc>().add(FetchPost());
            },
          );
        } else if (state is PostFetched) {
          return _PostList(context, state.post);
        } else {
          return const Text('Not support');
        }
      },
    );
  }
  Widget _createFollowsList(BuildContext context) {
    return BlocBuilder<UserBloc3, UserStateFollow>(
      builder: (context, state) {
        if (state is BlocUserInitialFollow) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserFetchErrorFollow) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<UserBloc3>().add(FetchUserListFollow());
            },
          );
        } else if (state is UserFetchedListFollow) {
          return _followsList(context, state.user);
        } else {
          return const Text('Not support');
        }
      },
    );
  }
   Widget _followsList(BuildContext context, List<Following> me){
    return  Column(
      children: [
        
        Padding(
          padding: const EdgeInsets.only(top:50.0),
          child: Text("Tus Comunidades", style: TextStyle(color: Style.VKNGGron),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(color: Style.LetraColor,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics() ,
                    itemBuilder: (BuildContext context, int index){
                      return _followItem(context , me[index] ) ;                         
                    },
                    itemCount: me.length ,
                  ),
                ],
              ),  

          ),
        ),
      ],
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
                reverse: true,
                itemCount: post.length,
              ),
            ],
          ),  
        
        
      ),
    );
  }

  Widget _followItem(BuildContext context, Following subpost){
    return InkWell(
      child: Row(
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
      ),
       onTap: (){
         Navigator.pushNamed(context, '/comunityFollowing',arguments: subpost);
       },
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
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left:10),
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