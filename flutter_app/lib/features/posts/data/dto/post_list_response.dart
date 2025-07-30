import 'package:json_annotation/json_annotation.dart';
import '../../domain/models/post.dart';

part 'post_list_response.g.dart';

@JsonSerializable()
class PostListResponse {
  final List<Post> posts;
  final Pagination pagination;

  const PostListResponse({
    required this.posts,
    required this.pagination,
  });

  factory PostListResponse.fromJson(Map<String, dynamic> json) => _$PostListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostListResponseToJson(this);
}

@JsonSerializable()
class Pagination {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  const Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}