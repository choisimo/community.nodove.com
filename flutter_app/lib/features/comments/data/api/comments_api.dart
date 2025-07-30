import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/models/comment.dart';
import '../dto/comment_list_response.dart';
import '../dto/create_comment_request.dart';

part 'comments_api.g.dart';

@RestApi()
abstract class CommentsApi {
  factory CommentsApi(Dio dio, {String baseUrl}) = _CommentsApi;

  @GET('/api/posts/{postId}/comments')
  Future<CommentListResponse> getComments(
    @Path('postId') int postId, {
    @Query('page') int page = 1,
    @Query('limit') int limit = 20,
  });

  @POST('/api/posts/{postId}/comments')
  Future<Comment> createComment(
    @Path('postId') int postId,
    @Body() CreateCommentRequest request,
    @Header('Authorization') String token,
  );

  @POST('/api/comments/{commentId}/reply')
  Future<Comment> replyToComment(
    @Path('commentId') int commentId,
    @Body() CreateCommentRequest request,
    @Header('Authorization') String token,
  );

  @PUT('/api/comments/{commentId}')
  Future<Comment> updateComment(
    @Path('commentId') int commentId,
    @Body() CreateCommentRequest request,
    @Header('Authorization') String token,
  );

  @DELETE('/api/comments/{commentId}')
  Future<void> deleteComment(
    @Path('commentId') int commentId,
    @Header('Authorization') String token,
  );

  @POST('/api/comments/{commentId}/like')
  Future<void> likeComment(
    @Path('commentId') int commentId,
    @Header('Authorization') String token,
  );

  @DELETE('/api/comments/{commentId}/like')
  Future<void> unlikeComment(
    @Path('commentId') int commentId,
    @Header('Authorization') String token,
  );
}