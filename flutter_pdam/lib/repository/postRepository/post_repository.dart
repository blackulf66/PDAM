import 'package:pdamfinal/models/auth/me_response.dart';
import 'package:pdamfinal/models/subpost/Subpost_response.dart';

import '../../models/post/post_dto.dart';
import '../../models/post/post_response.dart';

abstract class PostApiRepository {
  Future<List<PostApiResponse>> fetchPosts();

  Future<List<PostListSU>> fetchPostsBySubpostId(String postid);

  Future<PostApiResponse> createPost(PostDto dto, String imagePath);
}