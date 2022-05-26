import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:pdamfinal/models/auth/me_response.dart';
import 'package:pdamfinal/models/post/post_response.dart';
import 'package:pdamfinal/repository/subpostRepository/subpost_repository_impl.dart';
import 'package:pdamfinal/ui/screens/ErrorPage.dart';

import '../../bloc/postbloc/bloc/post_bloc.dart';
import '../../bloc/user/bloc/user_bloc.dart';
import '../../constants.dart';
import '../../repository/postRepository/post_repository.dart';
import '../../repository/postRepository/post_repository_impl.dart';
import '../../repository/userRepository/user_repository.dart';
import '../../repository/userRepository/user_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late UserRepository userRepository;
  late PostApiRepository postApiRepository;

  @override
    void initState() {
    super.initState();
    userRepository = UserRepositoryImpl();
    postApiRepository = PostApiRepositoryImpl();
  }
  @override
  void dispose() {
    super.dispose();
  }
@override
  Widget build(BuildContext context) {
    return
    MultiBlocProvider(
  providers: [
    BlocProvider<PostBloc>(
      create: (context) => PostBloc(postApiRepository)..add(FetchPost()),
    ),
    BlocProvider<UserBloc>(
      create: (context) => UserBloc(userRepository)..add(FetchUser()),
    ),
  ],
    child: DefaultTabController(
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
              listadepost(),
              listadefollows(),
            ],
          ),
        ),
      ),);
  }

Widget Perfil(BuildContext context, MeResponse me){
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
                me.username,
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
                      backgroundImage: NetworkImage(
                          me.avatar),
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
    body: SingleChildScrollView(
      child: Column(
        children: [
          _createUserProfile(context),
          _createPostList(context),
        ],
      ),
    )
  

  );

}

Widget listadefollows(){
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          _createFollowsList(context),
        ],
      ),
    )
  

  );

}
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
          return _followsList(context, state.user);
        } else {
          return const Text('Not support');
        }
      },
    );
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
        } else if (state is UserSuccessState) {
          return Perfil(context , state.meResponse);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _PostList(BuildContext context, List<PostApiResponse> post){
    return  Container(
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
      
      
    );
  }

   Widget _followsList(BuildContext context, List<MeResponse> me){
    return  Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics() ,
              itemBuilder: (BuildContext context, int index){
                return _follow(context , me[index] ) ;                         
              },
              itemCount: me.length,
            ),
          ],
        ),  
      
      
    );
  }

  Widget _follow(BuildContext context,MeResponse me){
    return Container(
      child:Text(me.email)
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
        
                     /* Container(
                        padding: EdgeInsets.only(top: 12.0 , left: 18.0, bottom: 12.0, right: 12.0 ),
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(50.0),
                          child: Image(
                            image: NetworkImage(post.imagenportada ),
                            height: 45.0,
                            width: 45.0,
                          ),
                        ),
                      ),*/
                   
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
            Navigator.pushNamed(context,'/detailpage');
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
                            onTap: (){},
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
 