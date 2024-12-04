import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yash_practical/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:yash_practical/presentation/dashboard/widget/dashboard_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (BuildContext context) => DashboardCubit(),
      child: DashboardWidget(
        cubit: DashboardCubit(),
      ),
    );
  }
}
