import 'package:hive_flutter/hive_flutter.dart';
import 'package:yash_practical/presentation/dashboard/models/posts_model.dart';

class LocalStorageService {
  static const _boxName = 'posts';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PostsModelAdapter());
    await Hive.openBox<PostsModel>(_boxName);
  }

  Box<PostsModel> get box => Hive.box<PostsModel>(_boxName);

  List<PostsModel> getPosts() => box.values.toList();

  Future<void> savePosts(List<PostsModel> posts) async {
    await box.clear();
    for (var post in posts) {
      box.put(post.id, post);
    }
  }
}
