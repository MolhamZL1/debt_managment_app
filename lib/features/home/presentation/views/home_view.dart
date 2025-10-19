import 'package:debt_managment_app/core/services/get_it_service.dart';
import 'package:debt_managment_app/features/home/domain/repo/home_view_repo.dart';
import 'package:debt_managment_app/features/home/presentation/cubits/cubit/home_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/CustomErrorMessage.dart';
import '../../../../core/widgets/CustomLoading.dart';
import 'widgets/HomeViewBody.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => HomeViewCubit(getIt.get<HomeViewRepo>())..getHomeView(),
      child: BlocBuilder<HomeViewCubit, HomeViewState>(
        builder: (context, state) {
          if (state is HomeViewLoading) {
            return CustomLoading();
          } else if (state is HomeViewError) {
            return CustomErrorMessage(message: state.failure);
          } else if (state is HomeViewSuccess) {
            return HomeViewBody(homeViewEntity: state.homeViewEntity);
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
