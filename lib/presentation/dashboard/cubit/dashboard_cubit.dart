import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yash_practical/core/constants/shared_preferences_constants.dart';
import 'package:yash_practical/core/local_storage/local_storage_service.dart';
import 'package:yash_practical/core/shared_preferences/shared_preferences_storage.dart';
import 'package:yash_practical/core/utility/enums/enum_status.dart';
import 'package:yash_practical/core/utility/utility.dart';
import 'package:yash_practical/models/result_model.dart';
import 'package:yash_practical/presentation/dashboard/models/posts_model.dart';
import 'package:yash_practical/presentation/dashboard/repository/dashboard_repository.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(InitialDashboardState());
  final DashboardRepository repository = DashboardRepository();
  final LocalStorageService localStorageService = LocalStorageService();
  SharedPreferencesStorage preferencesStorage = SharedPreferencesStorage();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  Status bannerStatus = Status.loading;
  List<PostsModel> postsList = <PostsModel>[];

  Future<void> callPostsApi() async {
    emit(LoadingPostsState());
    try {
      final ResultModel result = await repository.callPostsApi();
      await localStorageService.savePosts(result.result);
      await SharedPreferencesStorage.setBool(
          keyPrefix: SharedPreferencesConstants.isSyncData, value: true);
      if (result.result != null) {
        postsList = result.result;
      }

      emit(SuccessPostsState());
    } catch (e) {
      Utility.showLog('Error in Posts Response: ${e.toString()}');
      emit(ErrorPostsState(error: e));
    }
  }

  Future<void> getHivePosts() async {
    emit(LoadingPostsState());
    List<PostsModel> postModel = localStorageService.getPosts();
    postsList = postModel;
    emit(SuccessPostsState());
  }

  Future<void> syncPostsData() async {
    bool isStoredData = await SharedPreferencesStorage.getBool(
        keyPrefix: SharedPreferencesConstants.isSyncData);
    if (isStoredData) {
      await getHivePosts();
    } else {
      await callPostsApi();
    }
  }

  Future<void> markPostAsRead({int? postId}) async {
    final post = postsList.firstWhere((pId) => pId.id == postId);
    post.isRead = true;
  }

  Future<void> refreshPosts() async {
    emit(LoadingPostsState());
    emit(RefreshPostsState());
  }
}
