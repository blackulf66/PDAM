import '../../models/post/post_dto.dart';
import '../../models/post/post_response.dart';

abstract class PostApiRepository {
  Future<List<PostApiResponse>> fetchPosts();

  Future<List<PostApiResponse>> fetchPostsBySubpostId(int postId);

  Future<PostApiResponse> createPost(PostDto dto, String imagePath);
}