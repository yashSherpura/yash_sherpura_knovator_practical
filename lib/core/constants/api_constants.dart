import 'package:yash_practical/main.dart';

class ApiConstants {
  static String baseUrl = apiBaseUrl;

  static const String keyContentType = 'Content-type';
  static const String keyContentTypeApplicationJson = 'application/json';

  static const String keySuccess = 'success';
  static const String keyError = 'error';
  static const String keyMessage = 'message';
  static const String keyReason = 'reason';
  static const String keyCode = 'code';
  static const String keyId = 'id';
  static const String keyUserId = 'userId';
  static const String keyTitle = 'title';
  static const String keyBody = 'body';
  static const String keyIsRead = 'isRead';

  static String getPosts() {
    return '/posts';
  }

  static String getPostDetail({required int postId}) {
    return '/posts/$postId';
  }
}
