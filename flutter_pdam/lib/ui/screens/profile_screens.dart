import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:pdamfinal/bloc/user/bloc2/user_bloc.dart';
import 'package:pdamfinal/bloc/user/bloc3/user_bloc.dart';
import 'package:pdamfinal/bloc/user/bloc/user_bloc.dart';
import 'package:pdamfinal/models/auth/me_response.dart';
import 'package:pdamfinal/repository/deleteRepository/delete_repository.dart';
import 'package:pdamfinal/repository/deleteRepository/delete_repository_impl.dart';
import 'package:pdamfinal/repository/followRepository/unfollow_repository.dart';
import 'package:pdamfinal/repository/followRepository/unfollow_repository_impl.dart';
import 'package:pdamfinal/ui/screens/ErrorPage.dart';

import '../../bloc/user/bloc/user_bloc.dart';
import '../../constants.dart';
import '../../repository/postRepository/post_repository.dart';
import '../../repository/postRepository/post_repository_impl.dart';
import '../../repository/userRepository/user_repository.dart';
import '../../repository/userRepository/user_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserRepository userRepository;
  late PostApiRepository postApiRepository;
  late UnFollowRepository unFollowRepository;
  late DeleteRepository deleteRepository;

  @override
  void initState() {
    super.initState();
    userRepository = UserRepositoryImpl();
    postApiRepository = PostApiRepositoryImpl();
    unFollowRepository = UnFollowRepositoryImpl();
    deleteRepository = DeleteRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(userRepository)..add(FetchUser()),
        ),
        BlocProvider<UserBloc3>(
          create: (context) =>
              UserBloc3(userRepository)..add(FetchUserListFollow()),
        ),
        BlocProvider<UserBlocPost>(
          create: (context) =>
              UserBlocPost(userRepository)..add(FetchUserListPost()),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Style.VKNGGron,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Typicons.user)),
                Tab(icon: Icon(Typicons.th_list)),
              ],
            ),
            title: const Text(''),
          ),
          body: TabBarView(
            children: <Widget>[
              listadepost(),
              listadefollows(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Perfil(BuildContext context, MeResponse me) {
    final date = DateTime.parse(me.created);
    return Center(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.black),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, bottom: 10, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    me.email,
                    style: TextStyle(
                      color: Style.LetraColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ),
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
                    backgroundImage: NetworkImage(me.avatar),
                  ),
                ),
              ),
              Center(
                  child: Text(
                "registrado desde: " +
                    date.day.toString() +
                    "/" +
                    date.month.toString() +
                    "/" +
                    date.year.toString(),
                style: TextStyle(color: Style.LetraColor),
              )),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(9),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                            color: Style.VKNGGron,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    child: Text('editar perfil'),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listadepost() {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          _createUserProfile(context),
          _createPostList(context),
        ],
      ),
    ));
  }

  Widget listadefollows() {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          _createFollowsList(context),
        ],
      ),
    ));
  }

  Widget _createPostList(BuildContext context) {
    return BlocBuilder<UserBlocPost, UserStatePost>(
      builder: (context, state) {
        if (state is BlocUserInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserFetchErrorPost) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<UserBlocPost>().add(FetchUserListPost());
            },
          );
        } else if (state is UserFetchedListPost) {
          return _PostList(context, state.user);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _createFollowsList(BuildContext context) {
    return BlocBuilder<UserBloc3, UserStateFollow>(
      builder: (context, state) {
        if (state is BlocUserInitial) {
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
          return Perfil(context, state.user);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _PostList(BuildContext context, List<PostList> post) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _Post(context, post[index]);
            },
            reverse: true,
            itemCount: post.length,
          ),
        ],
      ),
    );
  }

  Widget _followsList(BuildContext context, List<Following> me) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _followItem(context, me[index]);
            },
            itemCount: me.length,
          ),
        ],
      ),
    );
  }

  Widget _followItem(BuildContext context, Following me) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image(
              image: NetworkImage(me.imagen),
              width: 80,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/comunityFollowing', arguments: me);
          },
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            me.nombre,
            style: TextStyle(color: Style.LetraColor),
          ),
        ),
        SizedBox(
          width: 90,
        ),
        InkWell(
          child: Icon(
            Icons.minimize_rounded,
            color: Colors.white,
          ),
          onTap: () {
            unFollowRepository.fetchUnFollow(me.id);
          },
        )
      ],
    ));
  }

  Widget _Post(BuildContext context, PostList post) {
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
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Text(
                      post.subpostsName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Style.LetraColor),
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
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                splashColor: Colors.purple,
                onTap: () {
                  Navigator.pushNamed(context, '/detailpagePostList',
                      arguments: post);
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Image(
                    image: NetworkImage(post.imagenportada),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 5.0, left: 7.0, right: 7.0, bottom: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "votos : " + post.voteCount.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        deleteRepository.fetchDelete(post.postId);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Typicons.cancel_circled, color: Colors.red),
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
