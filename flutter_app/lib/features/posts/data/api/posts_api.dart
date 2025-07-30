import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/models/post.dart';
import '../../domain/models/category.dart';
import '../dto/post_list_response.dart';
import '../dto/create_post_request.dart';

part 'posts_api.g.dart';

@RestApi()
abstract class PostsApi {
  factory PostsApi(Dio dio, {String baseUrl}) = _PostsApi;

  @GET('/api/posts')
  Future<PostListResponse> getPosts({
    @Query('page') int page = 1,
    @Query('limit') int limit = 10,
    @Query('category') String? category,
    @Query('sort') String sort = 'latest',
  });

  @GET('/api/posts/{id}')
  Future<Post> getPost(@Path('id') int id);

  @POST('/api/posts')
  Future<Post> createPost(
    @Body() CreatePostRequest request,
    @Header('Authorization') String token,
  );

  @PUT('/api/posts/{id}')
  Future<Post> updatePost(
    @Path('id') int id,
    @Body() CreatePostRequest request,
    @Header('Authorization') String token,
  );

  @DELETE('/api/posts/{id}')
  Future<void> deletePost(
    @Path('id') int id,
    @Header('Authorization') String token,
  );

  @GET('/api/posts/recommended')
  Future<List<Post>> getRecommendedPosts({
    @Query('limit') int limit = 5,
  });

  @GET('/api/posts/latest')
  Future<List<Post>> getLatestPosts({
    @Query('limit') int limit = 10,
  });

  @GET('/api/categories')
  Future<List<Category>> getCategories();

  @GET('/api/categories/popular')
  Future<List<Category>> getPopularCategories({
    @Query('limit') int limit = 5,
  });
}