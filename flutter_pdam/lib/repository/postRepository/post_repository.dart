import '../../models/auth/post_response.dart';
import '../../models/post/post_dto.dart';

abstract class PostApiRepository {
  Future<List<PostApiResponse>> fetchPosts(String type);

  Future<PostApiResponse> createPost(PostDto dto, String imagePath);
}