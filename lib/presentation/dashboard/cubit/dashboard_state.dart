part of 'dashboard_cubit.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class InitialDashboardState extends DashboardState {
  @override
  List<Object> get props => <Object>[];
}

class LoadingPostsState extends DashboardState {
  @override
  List<Object> get props => <Object>[];
}

class SuccessPostsState extends DashboardState {
  @override
  List<Object> get props => <Object>[];
}

class ErrorPostsState extends DashboardState {
  const ErrorPostsState({required this.error});

  final Object error;

  @override
  List<Object> get props => <Object>[error];
}

class RefreshPostsState extends DashboardState {
  @override
  List<Object> get props => <Object>[];
}
