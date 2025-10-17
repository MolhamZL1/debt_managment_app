import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/payment_client_repo.dart';
import 'package:meta/meta.dart';

part 'add_payment_state.dart';

class AddPaymentCubit extends Cubit<AddPaymentState> {
  AddPaymentCubit(this.paymentClientRepo) : super(AddPaymentInitial());
  final PaymentClientRepo paymentClientRepo;
  Future<void> addPayment({
    required int clientId,
    required double amount,
    String? note,
  }) async {
    emit(AddPaymentLoading());
    final res = await paymentClientRepo.addPaymentToClient(
      clientId,
      amount,
      note,
    );
    res.fold(
      (l) => emit(AddPaymentError(l.errMessage)),
      (r) => emit(AddPaymentSuccess()),
    );
  }
}
