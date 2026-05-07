import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/debt_client_repo.dart';
import 'package:meta/meta.dart';

import '../../../../../core/entities/debt_entity.dart';

part 'fetch_debts_client_state.dart';

class FetchDebtsClientCubit extends Cubit<FetchDebtsClientState> {
  FetchDebtsClientCubit(this.debtClientRepo) : super(FetchDebtsClientInitial());
  final DebtClientRepo debtClientRepo;
  static const int _pageSize = 10;

  int _currentPage = 1;
  int? _currentClientId;
  bool _isFetchingMore = false;

  Future<void> fetchDebtsClient(int clientId) async {
    _currentClientId = clientId;
    _currentPage = 1;
    emit(FetchDebtsClientLoading());

    final result = await debtClientRepo.getAllDebtsOfClient(
      clientId,
      page: _currentPage,
    );

    result.fold(
      (failure) => emit(FetchDebtsClientError(errMessage: failure.errMessage)),
      (debts) => emit(
        FetchDebtsClientSuccess(
          debts: debts,
          hasMore: debts.length == _pageSize,
        ),
      ),
    );
  }

  Future<void> fetchMoreDebtsClient() async {
    final currentState = state;
    if (currentState is! FetchDebtsClientDataState) {
      return;
    }
    if (_isFetchingMore || !currentState.hasMore || _currentClientId == null) {
      return;
    }

    _isFetchingMore = true;

    emit(
      FetchDebtsClientLoadingMore(
        debts: currentState.debts,
        hasMore: currentState.hasMore,
      ),
    );

    final nextPage = _currentPage + 1;
    final result = await debtClientRepo.getAllDebtsOfClient(
      _currentClientId!,
      page: nextPage,
    );

    result.fold(
      (failure) => emit(
        FetchDebtsClientLoadMoreError(
          debts: currentState.debts,
          hasMore: currentState.hasMore,
          failure: failure.errMessage,
        ),
      ),
      (debts) {
        _currentPage = nextPage;
        emit(
          FetchDebtsClientSuccess(
            debts: [...currentState.debts, ...debts],
            hasMore: debts.length == _pageSize,
          ),
        );
      },
    );

    _isFetchingMore = false;
  }
}
