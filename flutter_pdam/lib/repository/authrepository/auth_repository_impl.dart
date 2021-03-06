
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pdamfinal/models/auth/me_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/auth/login_dto.dart';
import '../../models/auth/login_response.dart';
import '../../models/auth/register_dto.dart';
import '../../models/auth/register_response.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Client _client = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      'Content-Type': 'application/json', 
    };

    final response = await _client.post(
        Uri.parse('https://pdam-prueba.herokuapp.com/auth/login'),
        headers: headers,
        body: jsonEncode(loginDto.toJson()));
    if (response.statusCode == 201) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('error al loguearse ');
    }
  }

  Future<List<MeResponse>> fetchPosts() async {
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
      throw Exception('Fail to load me');
    }
  }

  @override
  Future<RegisterResponse> register(
      RegisterDto registerDto, String imagePath) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      // 'Authorization': 'Bearer $token'
    };

    var uri = Uri.parse('https://pdam-prueba.herokuapp.com/auth/register');
                    var request = http.MultipartRequest('POST', uri);
                    request.fields['username'] = registerDto.username;
                    request.fields['email'] = registerDto.email;
                    request.fields['password'] = registerDto.password;
                    request.fields['role'] = registerDto.role;
                    request.files.add(await http.MultipartFile.fromPath('file', imagePath));
                    request.headers.addAll(headers);
                    var response = await request.send();
                    if (response.statusCode == 201) print('Uploaded!');

    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      print(response.statusCode);
      throw Exception(response.statusCode);
    }
  }

  
}