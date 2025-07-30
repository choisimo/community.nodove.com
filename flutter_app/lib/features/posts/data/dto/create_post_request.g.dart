// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePostRequest _$CreatePostRequestFromJson(Map<String, dynamic> json) =>
    CreatePostRequest(
      title: json['title'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CreatePostRequestToJson(CreatePostRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'category': instance.category,
      'tags': instance.tags,
    };
