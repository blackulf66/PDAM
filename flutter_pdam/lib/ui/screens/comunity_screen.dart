import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:http/http.dart';
import 'package:pdamfinal/models/subpost/Subpost_response.dart';

import 'package:pdamfinal/models/vote/vote_dto.dart';
import 'package:pdamfinal/repository/postRepository/post_repository.dart';
import 'package:pdamfinal/repository/postRepository/post_repository_impl.dart';
import 'package:pdamfinal/repository/voteRepository/vote_repository.dart';
import 'package:pdamfinal/repository/voteRepository/vote_repository_impl.dart';

import '../../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class Comunitycreen extends StatefulWidget {
  Comunitycreen({Key? key}) : super(key: key);

  @override
  _ComunitycreenState createState() => _ComunitycreenState();
}

class _ComunitycreenState extends State<Comunitycreen> {

  final Client _client = Client();

  late VoteRepository voteRepository;

  late PostApiRepository postApiRepository;

  late Future<List<PostListSU>> items2;

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

   
    final subpost =
        ModalRoute.of(context)!.settings.arguments as SubPostApiResponse;

         items2 = fetchPostsBySubpostname(subpost.nombre);

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
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Image(image: NetworkImage(subpost.imagen)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      subpost.nombre,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      subpost.descripcion,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "publicada en: " + subpost.createdDate,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: FutureBuilder<List<PostListSU>>(
                    future: items2,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _PostList(snapshot.data!);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      {
                        return const Text("buscando");
                      }
                    }),
              ),
            ],
          ),
        )));
  }

  Widget _PostList(List<PostListSU> post) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _Post(post.elementAt(index), index);
              },
              itemCount: post.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget _Post(PostListSU post, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: post.subpostsName == 'DC' ? Color.fromARGB(36, 33, 149, 243) : Color.fromARGB(123, 244, 67, 54),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            children: <Widget>[
             
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
                  ],
                ),
              ),
              InkWell(
                splashColor: Colors.purple,
                onTap: () {
                  Navigator.pushNamed(context, '/detailpage', arguments: post);
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
                    InkWell(
                      onTap: () async {
                        final VoteDto voteDto =
                            VoteDto(voteType: 'LIKE', postId: post.postId);

                        voteRepository.fetchVote(voteDto);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.check,
                          color: Style.LetraColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        post.voteCount.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final VoteDto voteDto =
                            VoteDto(voteType: 'DISLIKE', postId: post.postId);

                        voteRepository.fetchVote(voteDto);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Typicons.cancel,
                          color: Style.LetraColor,
                        ),
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

  Future<List<PostListSU>> fetchPostsBySubpostname(String subpostname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await _client.get(
      Uri.parse(
          'https://pdam-prueba.herokuapp.com/subpost/${subpostname}'),
      headers: {
        'Authorization':
            /*'Bearer ${Constantes.token}',*/
            'Bearer ${prefs.getString('token')}'
      },
    );
    if (response.statusCode == 200) {
      return SubPostApiResponse.fromJson(jsonDecode(response.body)).postList;
    } else {
      throw Exception('Fail to load subpost');
    }
  }
}
