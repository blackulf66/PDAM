import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:pdamfinal/models/subpost/Subpost_response.dart';
import 'package:pdamfinal/repository/followRepository/follow_repository.dart';
import 'package:pdamfinal/repository/followRepository/follow_repository_impl.dart';
import 'package:pdamfinal/ui/screens/ErrorPage.dart';

import '../../bloc/subpost/bloc/subpost_bloc.dart';
import '../../constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/subpostRepository/subpost_repository.dart';
import '../../repository/subpostRepository/subpost_repository_impl.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
    late SubPostApiRepository subPostApiRepository;
    late FollowRepository followRepository;

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Busca aqui tu comunidad');
  @override
    void initState() {
    super.initState();
    subPostApiRepository = SubPostApiRepositoryImpl();
    followRepository = FollowRepositoryImpl();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubPostBloc>(
      create: (context) => SubPostBloc(subPostApiRepository)..add(FetchSubPost()),
    child:
      _createComunityList(context)
    
      
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
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics() ,
              itemBuilder: (BuildContext context, int index){
                return _subPostItem(context , post[index] ) ;                         
              },
              itemCount: post.length
            ),
          ],
        ),  
      
      
    );
  }
   Widget _subPostItem(BuildContext context, SubPostApiResponse subpost){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        
          InkWell(
            child: ClipRRect(
                            borderRadius:BorderRadius.horizontal(),
                            child: Image(
                              image: NetworkImage(subpost.imagen ),
                              height: 100.0,
                              width: 100.0,
                            ),
                          ),
                          onTap: (){
         Navigator.pushNamed(context, '/comunity',arguments: subpost);
       },
          ),
          
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(subpost.nombre , style: TextStyle(color: Style.LetraColor
),),
        ),
        InkWell(
                child: Container(
                  child: Icon(Icons.add, color: Colors.white, size: 35),
                ),
                onTap: () {
                  followRepository.fetchFollow(subpost.id);
                })
      

      ],
    );
}
}