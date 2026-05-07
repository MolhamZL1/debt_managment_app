import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/clientes_repo.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/client_entity.dart';

part 'fetch_clients_state.dart';

class FetchClientsCubit extends Cubit<FetchClientsState> {
  FetchClientsCubit(this.clientesRepo) : super(FetchClientsInitial());
  final ClientesRepo clientesRepo;
  static const int _pageSize = 10;

  int _currentPage = 1;
  bool _isFetchingMore = false;
  String currentCategory = "all";

  Future<void> fetchClients({required String category}) async {
    currentCategory = category;
    _currentPage = 1;
    emit(FetchClientsLoading());

    final result = await clientesRepo.getAllClientes(
      category: category,
      page: _currentPage,
    );

    result.fold(
      (failure) => emit(FetchClientsError(failure: failure.errMessage)),
      (clients) => emit(
        FetchClientsSuccess(
          clients: clients,
          hasMore: clients.length == _pageSize,
        ),
      ),
    );
  }

  Future<void> fetchMoreClients() async {
    final currentState = state;
    if (currentState is! FetchClientsDataState) {
      return;
    }
    if (_isFetchingMore || !currentState.hasMore) {
      return;
    }

    _isFetchingMore = true;

    emit(
      FetchClientsLoadingMore(
        clients: currentState.clients,
        hasMore: currentState.hasMore,
      ),
    );

    final nextPage = _currentPage + 1;
    final result = await clientesRepo.getAllClientes(
      category: currentCategory,
      page: nextPage,
    );

    result.fold(
      (failure) => emit(
        FetchClientsLoadMoreError(
          clients: currentState.clients,
          hasMore: currentState.hasMore,
          failure: failure.errMessage,
        ),
      ),
      (clients) {
        _currentPage = nextPage;
        emit(
          FetchClientsSuccess(
            clients: [...currentState.clients, ...clients],
            hasMore: clients.length == _pageSize,
          ),
        );
      },
    );

    _isFetchingMore = false;
  }
}
