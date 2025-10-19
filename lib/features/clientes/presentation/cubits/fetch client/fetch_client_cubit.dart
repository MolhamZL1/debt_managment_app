import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/clientes_repo.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/client_entity.dart';

part 'fetch_client_state.dart';

class FetchClientCubit extends Cubit<FetchClientState> {
  FetchClientCubit(this.clientesRepo) : super(FetchClientInitial());
  final ClientesRepo clientesRepo;
  Future<void> fetchClient(int clientId) async {
    emit(FetchClientLoading());
    final result = await clientesRepo.getCliente(clientId: clientId);
    result.fold(
      (failure) => emit(FetchClientError(failure.errMessage)),
      (clientEntity) => emit(FetchClientSuccess(clientEntity)),
    );
  }
}
