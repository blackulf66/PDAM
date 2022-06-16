
import 'dart:convert';
import 'package:http/http.dart';
import 'package:pdamfinal/repository/followRepository/follow_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';



class FollowRepositoryImpl extends FollowRepository {
  final Client _client = Client();

  @override
  void fetchFollow(int followid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await _client.post(Uri.parse('https://pdam-prueba.herokuapp.com/follow/${followid}'),headers:{
      'Content-Type':"application/json",
      'Authorization':
            /*'Bearer ${Constantes.token}',*/
             'Bearer ${prefs.getString('token')}'
             
   });
  }
}
