import 'package:flutter_chat_client/artifacts/dto/post.dart';
import 'package:flutter_chat_client/artifacts/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostService implements PostRepo {
  final String baseUrl;

  PostService({required this.baseUrl});

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

final postServiceProvider = Provider<PostRepo>(
  (ref) {
    return PostService(baseUrl: "https://community-backend.nodove.com");
  },
);
