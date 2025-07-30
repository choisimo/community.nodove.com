import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'likes_api.g.dart';

@RestApi()
abstract class LikesApi {
  factory LikesApi(Dio dio, {String baseUrl}) = _LikesApi;

  @POST('/api/posts/{postId}/like')
  Future<void> likePost(
    @Path('postId') int postId,
    @Header('Authorization') String token,
  );

  @DELETE('/api/posts/{postId}/like')
  Future<void> unlikePost(
    @Path('postId') int postId,
    @Header('Authorization') String token,
  );

  @GET('/api/posts/{postId}/likes')
  Future<List<dynamic>> getPostLikes(
    @Path('postId') int postId,
    @Header('Authorization') String token,
  );

  @GET('/api/user/liked-posts')
  Future<List<dynamic>> getUserLikedPosts(
    @Header('Authorization') String token, {
    @Query('page') int page = 1,
    @Query('limit') int limit = 10,
  });
}