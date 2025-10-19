import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/clientes_repo.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/client_entity.dart';

part 'fetch_clients_state.dart';

class FetchClientsCubit extends Cubit<FetchClientsState> {
  FetchClientsCubit(this.clientesRepo) : super(FetchClientsInitial());
  final ClientesRepo clientesRepo;
  Future<void> fetchClients({required String category}) async {
    emit(FetchClientsLoading());
    final result = await clientesRepo.getAllClientes(category: category);
    result.fold(
      (failure) => emit(FetchClientsError(failure: failure.errMessage)),
      (clients) => emit(FetchClientsSuccess(clients: clients)),
    );
  }
}
