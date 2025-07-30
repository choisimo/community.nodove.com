import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../posts/domain/models/post.dart';
import '../../posts/data/dto/post_list_response.dart';

part 'search_api.g.dart';

@RestApi()
abstract class SearchApi {
  factory SearchApi(Dio dio, {String baseUrl}) = _SearchApi;

  @GET('/api/search')
  Future<PostListResponse> searchPosts({
    @Query('query') required String query,
    @Query('page') int page = 1,
    @Query('limit') int limit = 10,
    @Query('category') String? category,
  });

  @GET('/api/search/suggestions')
  Future<List<String>> getSearchSuggestions({
    @Query('query') required String query,
    @Query('limit') int limit = 5,
  });
}