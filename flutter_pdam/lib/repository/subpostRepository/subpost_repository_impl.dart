import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../models/post/post_dto.dart';
import '../../models/auth/post_response.dart';
import '../../models/subpost/Subpost_response.dart';
import 'subpost_repository.dart';

class SubPostApiRepositoryImpl extends SubPostApiRepository {
  final Client _client = Client();

@override
  Future<List<SubPostApiResponse>> fetchSubPosts() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();

   //localhost:http://10.0.2.2:8080/
                
    final response = await _client.get(Uri.parse('https://pdam-prueba.herokuapp.com/subpost/all'),headers: {
        'Authorization':
            /*'Bearer ${Constantes.token}',*/
             'Bearer ${prefs.getString('token')}'
    },);
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List).map((i) =>
              SubPostApiResponse.fromJson(i)).toList();
    } else {
      throw Exception('Fail to load subpost');
    }
  }

}