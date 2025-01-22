import 'package:flutter_chat_client/artifacts/dto/post.dart';
import 'package:flutter_chat_client/artifacts/repository/post_repository.dart';

class PostService implements PostRepo {
  @override
  Future<Post> createPost(Post post) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<Post> getPostDetail(int postId) {
    // TODO: implement getPostDetail
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getPosts(int pageNum, int pageSize) async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(
        pageSize,
        (index) => Post(
            id: index, title: 'Post $index', content: 'Post $index content'));
  }
}
