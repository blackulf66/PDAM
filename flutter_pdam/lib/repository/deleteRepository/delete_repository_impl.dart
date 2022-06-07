
import 'dart:convert';
import 'package:http/http.dart';
import 'package:pdamfinal/repository/deleteRepository/delete_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DeleteRepositoryImpl extends DeleteRepository {
  final Client _client = Client();

  @override
  void fetchDelete(int deleteid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await _client.delete(Uri.parse('https://pdam-prueba.herokuapp.com/post/${deleteid}'),headers:{
      'Content-Type':"application/json",
      'Authorization':
            /*'Bearer ${Constantes.token}',*/
             'Bearer ${prefs.getString('token')}'
             
   });
  }
}
