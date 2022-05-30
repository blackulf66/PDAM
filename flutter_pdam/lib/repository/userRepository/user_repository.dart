import '../../models/auth/login_dto.dart';
import '../../models/auth/login_response.dart';
import '../../models/auth/me_response.dart';
import '../../models/auth/register_dto.dart';
import '../../models/auth/register_response.dart';

abstract class UserRepository {
  Future<MeResponse> fetchUser();
  

}