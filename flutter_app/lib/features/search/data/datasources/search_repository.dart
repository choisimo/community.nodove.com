import '../api/search_api.dart';
import '../../posts/domain/models/post.dart';
import '../../posts/data/dto/post_list_response.dart';

class SearchRepository {
  final SearchApi _searchApi;

  SearchRepository(this._searchApi);

  Future<List<Post>> searchPosts({
    required String query,
    int page = 1,
    int limit = 10,
    String? category,
  }) async {
    final response = await _searchApi.searchPosts(
      query: query,
      page: page,
      limit: limit,
      category: category,
    );
    return response.posts;
  }

  Future<List<String>> getSearchSuggestions({
    required String query,
    int limit = 5,
  }) async {
    return await _searchApi.getSearchSuggestions(
      query: query,
      limit: limit,
    );
  }
}