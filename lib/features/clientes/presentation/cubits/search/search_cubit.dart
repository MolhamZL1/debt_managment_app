import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/main/domain/entities/ClientSearchDropDownEntity.dart';
import 'package:debt_managment_app/features/main/domain/repo/ClientSearchDropDown_repo.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.clientSearchDropDownRepo) : super(SearchInitial());
  final ClientSearchDropDownRepo clientSearchDropDownRepo;
  Future<void> fetchSearchDropDownData(String query) async {
    emit(SearchLoading());
    try {
      final result = await clientSearchDropDownRepo.searchClients(query);

      emit(SearchSuccess(results: result));
    } catch (e) {
      emit(SearchFailure(message: "حدث خطأ ما، يرجى المحاولة مرة أخرى"));
    }
  }
}
