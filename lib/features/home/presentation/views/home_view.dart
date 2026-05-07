import 'package:debt_managment_app/features/home/presentation/cubits/cubit/home_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/CustomErrorMessage.dart';
import '../../../../core/widgets/CustomLoading.dart';
import 'widgets/HomeViewBody.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  initState() {
    super.initState();
    context.read<HomeViewCubit>().getHomeView();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewCubit, HomeViewState>(
      builder: (context, state) {
        if (state is HomeViewLoading) {
          return CustomLoading();
        } else if (state is HomeViewError) {
          return CustomErrorMessage(
            message: state.failure,
            onReload: () => context.read<HomeViewCubit>().getHomeView(),
          );
        } else if (state is HomeViewSuccess) {
          return HomeViewBody(homeViewEntity: state.homeViewEntity);
        } else {
          return SizedBox();
        }
      },
    );
  }
}
