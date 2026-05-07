import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/clientes_repo.dart';
import 'package:meta/meta.dart';

part 'delete_client_state.dart';

class DeleteClientCubit extends Cubit<DeleteClientState> {
  DeleteClientCubit(this.clientesRepo) : super(DeleteClientInitial());

  final ClientesRepo clientesRepo;

  Future<void> deleteClient(int clientId) async {
    emit(DeleteClientLoading());

    final result = await clientesRepo.deleteCliente(clientId);

    result.fold(
      (failure) => emit(DeleteClientError(message: failure.errMessage)),
      (_) => emit(DeleteClientSuccess()),
    );
  }
}
