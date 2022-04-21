import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../models/auth/post_dto.dart';
import '../../models/auth/post_response.dart';
import 'post_repository.dart';

class PostApiRepositoryImpl extends PostApiRepository {
  final Client _client = Client();

@override
  Future<List<PostApiResponse>> fetchPosts(String type) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();

   //localhost:http://10.0.2.2:8080/
                
    final response = await _client.get(Uri.parse('https://pdam-prueba.herokuapp.com/post/public'),headers: {
        'Authorization':
            /*'Bearer ${Constantes.token}',*/
             'Bearer ${prefs.getString('token')}'
    },);
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List).map((i) =>
              PostApiResponse.fromJson(i)).toList();
    } else {
      throw Exception('Fail to load post');
    }
  }

@override
  Future<PostApiResponse> createPost(PostDto postdto, String imagePath) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    Map<String, String> headers = {
      'Authorization': 'Bearer ${prefs.getString('token')}',
    };
    var uri = Uri.parse('http://10.0.2.2:8080/post/');
                    var request = http.MultipartRequest('POST', uri);
                    request.fields['titulo'] = postdto.titulo;
                    request.fields['texto'] = postdto.texto;
                    request.fields['postEnum'] = postdto.postEnum;
                    request.files.add(await http.MultipartFile.fromPath('file', imagePath));
                    request.headers.addAll(headers);
                    var response = await request.send();
                    if (response.statusCode == 201) print('Uploaded!');

    if (response.statusCode == 201) {
      return PostApiResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      print(response.statusCode);
      throw Exception(response.statusCode);
    }
  }

}