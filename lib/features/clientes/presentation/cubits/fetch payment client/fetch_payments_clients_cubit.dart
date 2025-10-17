import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/payment_client_repo.dart';
import 'package:meta/meta.dart';

import '../../../../../core/entities/payment_entity.dart';

part 'fetch_payments_clients_state.dart';

class FetchPaymentsClientsCubit extends Cubit<FetchPaymentsClientsState> {
  FetchPaymentsClientsCubit(this.paymentClientRepo)
    : super(FetchPaymentsClientsInitial());
  final PaymentClientRepo paymentClientRepo;

  Future<void> fetchPaymentsOfClient(int clientId) async {
    emit(FetchPaymentsClientsLoading());
    final result = await paymentClientRepo.getAllPaymentsOfClient(clientId);
    result.fold(
      (l) => emit(FetchPaymentsClientsError(errMessage: l.errMessage)),
      (r) => emit(FetchPaymentsClientsSuccess(payments: r)),
    );
  }
}
