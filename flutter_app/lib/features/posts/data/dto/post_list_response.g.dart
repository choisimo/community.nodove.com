// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostListResponse _$PostListResponseFromJson(Map<String, dynamic> json) =>
    PostListResponse(
      posts: (json['posts'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostListResponseToJson(PostListResponse instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'pagination': instance.pagination,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'totalPages': instance.totalPages,
    };
