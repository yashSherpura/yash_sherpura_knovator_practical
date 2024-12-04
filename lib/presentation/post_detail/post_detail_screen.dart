import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yash_practical/core/navigation/argument.dart';
import 'package:yash_practical/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:yash_practical/presentation/post_detail/cubit/post_detail_cubit.dart';
import 'package:yash_practical/presentation/post_detail/widget/post_detail_widget.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ArgumentPostDetailScreen args =
        ModalRoute.of(context)!.settings.arguments! as ArgumentPostDetailScreen;
    return BlocProvider<DashboardCubit>(
      create: (BuildContext context) => DashboardCubit(),
      child: PostDetailWidget(
        postId: args.postId,
        cubit: PostDetailCubit(),
      ),
    );
  }
}
