import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/payment_client_repo.dart';
import 'package:meta/meta.dart';

import '../../../../../core/entities/payment_entity.dart';

part 'fetch_payments_clients_state.dart';

class FetchPaymentsClientsCubit extends Cubit<FetchPaymentsClientsState> {
  FetchPaymentsClientsCubit(this.paymentClientRepo)
    : super(FetchPaymentsClientsInitial());
  final PaymentClientRepo paymentClientRepo;
  static const int _pageSize = 10;

  int _currentPage = 1;
  int? _currentClientId;
  bool _isFetchingMore = false;

  Future<void> fetchPaymentsOfClient(int clientId) async {
    _currentClientId = clientId;
    _currentPage = 1;
    emit(FetchPaymentsClientsLoading());

    final result = await paymentClientRepo.getAllPaymentsOfClient(
      clientId,
      page: _currentPage,
    );

    result.fold(
      (l) => emit(FetchPaymentsClientsError(errMessage: l.errMessage)),
      (r) => emit(
        FetchPaymentsClientsSuccess(
          payments: r,
          hasMore: r.length == _pageSize,
        ),
      ),
    );
  }

  Future<void> fetchMorePaymentsOfClient() async {
    final currentState = state;
    if (currentState is! FetchPaymentsClientsDataState) {
      return;
    }
    if (_isFetchingMore || !currentState.hasMore || _currentClientId == null) {
      return;
    }

    _isFetchingMore = true;

    emit(
      FetchPaymentsClientsLoadingMore(
        payments: currentState.payments,
        hasMore: currentState.hasMore,
      ),
    );

    final nextPage = _currentPage + 1;
    final result = await paymentClientRepo.getAllPaymentsOfClient(
      _currentClientId!,
      page: nextPage,
    );

    result.fold(
      (failure) => emit(
        FetchPaymentsClientsLoadMoreError(
          payments: currentState.payments,
          hasMore: currentState.hasMore,
          failure: failure.errMessage,
        ),
      ),
      (payments) {
        _currentPage = nextPage;
        emit(
          FetchPaymentsClientsSuccess(
            payments: [...currentState.payments, ...payments],
            hasMore: payments.length == _pageSize,
          ),
        );
      },
    );

    _isFetchingMore = false;
  }
}
