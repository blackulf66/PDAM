
import 'dart:convert';
import 'package:http/http.dart';
import 'package:pdamfinal/repository/followRepository/unfollow_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';



class UnFollowRepositoryImpl extends UnFollowRepository {
  final Client _client = Client();

  @override
  void fetchUnFollow(int unfollowid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await _client.post(Uri.parse('https://pdam-prueba.herokuapp.com/unfollow/${unfollowid}'),headers:{
      'Content-Type':"application/json",
      'Authorization':
            /*'Bearer ${Constantes.token}',*/
             'Bearer ${prefs.getString('token')}'
             
   });
  }
}
