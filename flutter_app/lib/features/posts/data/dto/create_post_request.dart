import 'package:json_annotation/json_annotation.dart';

part 'create_post_request.g.dart';

@JsonSerializable()
class CreatePostRequest {
  final String title;
  final String content;
  final String category;
  final List<String> tags;

  const CreatePostRequest({
    required this.title,
    required this.content,
    required this.category,
    required this.tags,
  });

  factory CreatePostRequest.fromJson(Map<String, dynamic> json) => _$CreatePostRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreatePostRequestToJson(this);
}