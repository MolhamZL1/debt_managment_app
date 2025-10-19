import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/home/domain/repo/home_view_repo.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/home_view_entity.dart';

part 'home_view_state.dart';

class HomeViewCubit extends Cubit<HomeViewState> {
  HomeViewCubit(this.homeViewRepo) : super(HomeViewInitial());
  final HomeViewRepo homeViewRepo;

  Future<void> getHomeView() async {
    emit(HomeViewLoading());
    final result = await homeViewRepo.getHomeView();
    result.fold(
      (l) => emit(HomeViewError(failure: l.errMessage)),
      (r) => emit(HomeViewSuccess(homeViewEntity: r)),
    );
  }
}
