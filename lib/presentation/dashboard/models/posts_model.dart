import 'package:hive/hive.dart';
import 'package:yash_practical/core/constants/constants.dart';

part 'posts_model.g.dart';

@HiveType(typeId: 1)
class PostsModel {
  PostsModel({
    this.userId,
    this.id,
    this.title,
    this.body,
    this.isRead = false,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        userId: json[ApiConstants.keyUserId],
        id: json[ApiConstants.keyId],
        title: json[ApiConstants.keyTitle],
        body: json[ApiConstants.keyBody],
      );

  @HiveField(0)
  final int? userId;
  @HiveField(1)
  final int? id;
  @HiveField(2)
  final String? title;
  @HiveField(3)
  final String? body;
  @HiveField(4)
  bool isRead;

  Map<String, dynamic> toJson() => <String, dynamic>{
        ApiConstants.keyUserId: userId,
        ApiConstants.keyId: id,
        ApiConstants.keyTitle: title,
        ApiConstants.keyBody: body,
        ApiConstants.keyIsRead: isRead,
      };
}
