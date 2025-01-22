import 'package:flutter_chat_client/artifacts/dto/post.dart';

abstract class PostRepo {
  // Get posts list by page number and pagination size
  Future<List<Post>> getPosts(int pageNum, int pageSize);

  // Get post detail by post ID
  Future<Post> getPostDetail(int postId);

  // Create a new post
  Future<Post> createPost(Post post);
}
