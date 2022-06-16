

import '../../models/subpost/Subpost_response.dart';

abstract class SubPostApiRepository {
  Future<List<SubPostApiResponse>> fetchSubPosts();
}