
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pdamfinal/bloc/user/bloc/user_bloc.dart';
import 'package:pdamfinal/models/auth/me_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/auth/login_dto.dart';
import '../../models/auth/login_response.dart';
import '../../models/auth/register_dto.dart';
import '../../models/auth/register_response.dart';
import 'user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final Client _client = Client();

@override
  Future<List<MeResponse>> fetchUser() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();

   //localhost:http://10.0.2.2:8080/
                
    final response = await _client.get(Uri.parse('https://pdam-prueba.herokuapp.com/me'),headers: {
        'Authorization':
            /*'Bearer ${Constantes.token}',*/
             'Bearer ${prefs.getString('token')}'
    },);
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List).map((i) =>
              MeResponse.fromJson(i)).toList();
    } else {
      throw Exception('Fail to load you user');
    }
  }

}