part of 'post_detail_cubit.dart';

abstract class PostDetailState extends Equatable {
  const PostDetailState();
}

class InitialPostDetailState extends PostDetailState {
  @override
  List<Object> get props => <Object>[];
}

class LoadingPostsDetailState extends PostDetailState {
  @override
  List<Object> get props => <Object>[];
}

class SuccessPostsDetailState extends PostDetailState {
  @override
  List<Object> get props => <Object>[];
}

class ErrorPostsDetailState extends PostDetailState {
  const ErrorPostsDetailState({required this.error});

  final Object error;

  @override
  List<Object> get props => <Object>[error];
}
