import 'package:json_annotation/json_annotation.dart';
import '../../domain/models/comment.dart';

part 'comment_list_response.g.dart';

@JsonSerializable()
class CommentListResponse {
  final List<Comment> comments;
  final int totalCount;
  final int page;
  final int limit;

  const CommentListResponse({
    required this.comments,
    required this.totalCount,
    required this.page,
    required this.limit,
  });

  factory CommentListResponse.fromJson(Map<String, dynamic> json) => _$CommentListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommentListResponseToJson(this);
}