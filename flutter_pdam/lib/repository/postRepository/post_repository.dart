import '../../models/post/post_dto.dart';
import '../../models/post/post_response.dart';

abstract class PostApiRepository {
  Future<List<PostApiResponse>> fetchPosts();

  Future<List<PostApiResponse>> fetchPostsBySubpostId(String postid);

  Future<PostApiResponse> createPost(PostDto dto, String imagePath);
}