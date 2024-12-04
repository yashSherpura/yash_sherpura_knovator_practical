import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yash_practical/commons/widgets/components.dart';
import 'package:yash_practical/commons/widgets/components/error_handling_widget.dart';
import 'package:yash_practical/core/constants/constants.dart';
import 'package:yash_practical/core/navigation/app_navigator.dart';
import 'package:yash_practical/presentation/post_detail/cubit/post_detail_cubit.dart';

class PostDetailWidget extends StatefulWidget {
  const PostDetailWidget(
      {super.key, required this.cubit, required this.postId});

  final PostDetailCubit cubit;
  final int postId;

  @override
  State<PostDetailWidget> createState() => _PostDetailWidgetState();
}

class _PostDetailWidgetState extends State<PostDetailWidget> {
  @override
  void initState() {
    widget.cubit.callPostsDetailApi(postId: widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarCustom(
        title: StringConstants.labelPostDetail,
        isShowBackButton: true,
        onLeadingPress: () {
          AppNavigator().popUp(context: context);
        },
      ),
      body: BlocConsumer(
        bloc: widget.cubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ErrorPostsDetailState) {
            return ErrorHandlingWidget(
              errorObject: state.props[0],
              onReconnect: () {
                widget.cubit.callPostsDetailApi(postId: widget.postId);
              },
            );
          } else {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Spacings.medium),
                  child: TextLabel(text: widget.cubit.postsData.body),
                ),
                if (state is LoadingPostsDetailState) const ProgressBar()
              ],
            );
          }
        },
      ),
    );
  }
}
