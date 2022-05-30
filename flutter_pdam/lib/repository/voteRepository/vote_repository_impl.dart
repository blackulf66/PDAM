
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pdamfinal/models/auth/me_response.dart';
import 'package:pdamfinal/models/vote/vote_response.dart';
import 'package:pdamfinal/repository/voteRepository/vote_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';



class VoteRepositoryImpl extends VoteRepository {
  final Client _client = Client();

@override
  Future<VoteResponse> fetchVote() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();

   //localhost:http://10.0.2.2:8080/
                
    final response = await _client.get(Uri.parse('https://pdam-prueba.herokuapp.com/votes/'),headers: {
        'Authorization':
            /*'Bearer ${Constantes.token}',*/
             'Bearer ${prefs.getString('token')}'
    },);
    if (response.statusCode == 200) {
      return VoteResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load you Vote');
    }
  }
}