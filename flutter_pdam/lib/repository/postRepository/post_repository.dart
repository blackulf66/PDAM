

import '../../models/auth/post_dto.dart';
import '../../models/auth/post_response.dart';

abstract class PostApiRepository {
  Future<List<PostApiResponse>> fetchPosts(String type);

  Future<PostApiResponse> createPost(PostDto dto, String imagePath);
}