import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yash_practical/commons/widgets/components.dart';
import 'package:yash_practical/commons/widgets/components/error_handling_widget.dart';
import 'package:yash_practical/core/constants/constants.dart';
import 'package:yash_practical/core/navigation/app_navigator.dart';
import 'package:yash_practical/core/themes/themes.dart';
import 'package:yash_practical/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:yash_practical/presentation/dashboard/widget/timer_widget.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({required this.cubit, super.key});

  final DashboardCubit cubit;

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  void initState() {
    widget.cubit.syncPostsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool isPop, dynamic) {
        exit(0);
      },
      child: AppScaffold(
        backgroundColor: Palette.white,
        scaffoldKey: widget.cubit.scaffoldKey,
        appBar: const AppBarCustom(
          title: StringConstants.labelPost,
        ),
        body: BlocConsumer<DashboardCubit, DashboardState>(
            bloc: widget.cubit,
            listener: (BuildContext context, DashboardState state) {},
            builder: (BuildContext context, DashboardState state) {
              if (state is ErrorPostsState) {
                return ErrorHandlingWidget(
                  errorObject: state.props[0],
                  onReconnect: () {
                    widget.cubit.syncPostsData();
                  },
                );
              } else {
                return Stack(
                  children: [
                    getBodyWidget(context, state),
                    if (state is LoadingPostsState) const ProgressBar()
                  ],
                );
              }
            }),
      ),
    );
  }

  Widget getBodyWidget(BuildContext context, DashboardState state) {
    return Padding(
      padding: const EdgeInsets.all(Spacings.medium),
      child: ListView.separated(
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                widget.cubit
                    .markPostAsRead(postId: widget.cubit.postsList[i].id);
                AppNavigator().navigateToPostDetail(
                    postId: widget.cubit.postsList[i].id ?? 1);
                widget.cubit.refreshPosts();
              },
              child: AppCardWidget(
                  color: widget.cubit.postsList[i].isRead
                      ? Palette.white
                      : Palette.secondaryColor!,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextLabel(
                                text:
                                    '${StringConstants.labelId}${int.parse(widget.cubit.postsList[i].id.toString()).toString()}'),
                            TextLabel(
                              text:
                                  '${StringConstants.labelTitle}${widget.cubit.postsList[i].title}',
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      TimerWidget(postId: widget.cubit.postsList[i].id)
                    ],
                  )),
            );
          },
          separatorBuilder: (context, i) {
            return const Divider();
          },
          itemCount: widget.cubit.postsList.length),
    );
  }
}
