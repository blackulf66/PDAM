
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pdamfinal/models/auth/me_response.dart';
import 'package:pdamfinal/models/vote/vote_dto.dart';
import 'package:pdamfinal/models/vote/vote_response.dart';
import 'package:pdamfinal/repository/voteRepository/vote_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';



class VoteRepositoryImpl extends VoteRepository {
  final Client _client = Client();

@override
  Future<VoteResponse> fetchVote(VoteDto voteDto) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await _client.post(Uri.parse('https://pdam-prueba.herokuapp.com/votes/'),headers:{
      'Content-Type':"application/json",
      'Authorization':
            /*'Bearer ${Constantes.token}',*/
             'Bearer ${prefs.getString('token')}'
             
   },

    body: jsonEncode(voteDto.toJson()));
    if (response.statusCode == 200) {
      return VoteResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load you Vote');
    }
  }
}