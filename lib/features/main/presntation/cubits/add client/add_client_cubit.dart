import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/clientes_repo.dart';
import 'package:meta/meta.dart';

part 'add_client_state.dart';

class AddClientCubit extends Cubit<AddClientState> {
  AddClientCubit(this.clientesRepo) : super(AddClientInitial());
  final ClientesRepo clientesRepo;

  Future<void> addClient({
    required String name,
    String? address,
    String? phone,
  }) async {
    emit(AddClientLoading());
    try {
      await clientesRepo.addCliente(name: name, address: address, phone: phone);
      emit(AddClientSuccess());
    } catch (e) {
      emit(AddClientFailure(e.toString()));
    }
  }
}
