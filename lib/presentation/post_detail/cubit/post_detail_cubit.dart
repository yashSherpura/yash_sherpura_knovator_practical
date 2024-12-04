import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yash_practical/core/utility/enums/enum_status.dart';
import 'package:yash_practical/core/utility/utility.dart';
import 'package:yash_practical/models/result_model.dart';
import 'package:yash_practical/presentation/dashboard/models/posts_model.dart';
import 'package:yash_practical/presentation/post_detail/repository/post_detail_repository.dart';

part 'post_detail_state.dart';

class PostDetailCubit extends Cubit<PostDetailState> {
  PostDetailCubit() : super(InitialPostDetailState());
  final PostDetailRepository repository = PostDetailRepository();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  Status bannerStatus = Status.loading;
  PostsModel postsData = PostsModel();

  Future<void> callPostsDetailApi({required int postId}) async {
    emit(LoadingPostsDetailState());
    try {
      final ResultModel result =
          await repository.callPostsDetailApi(postId: postId);
      if (result.result != null) {
        postsData = result.result;
      }
      emit(SuccessPostsDetailState());
    } catch (e) {
      Utility.showLog('Error in Posts Response: ${e.toString()}');
      emit(ErrorPostsDetailState(error: e));
    }
  }
}
