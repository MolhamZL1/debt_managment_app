import 'package:debt_managment_app/features/clientes/domain/repo/payment_client_repo.dart';
import 'package:debt_managment_app/features/clientes/presentation/cubits/fetch%20payment%20client/fetch_payments_clients_cubit.dart';
import 'package:debt_managment_app/features/clientes/presentation/views/widgets/payment_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';

import 'widgets/client_view_body.dart';

class PaidClientsView extends StatefulWidget {
  const PaidClientsView({super.key, required this.clientId});
  final int clientId;

  @override
  State<PaidClientsView> createState() => _PaidClientsViewState();
}

class _PaidClientsViewState extends State<PaidClientsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create:
          (context) =>
              FetchPaymentsClientsCubit(getIt.get<PaymentClientRepo>())
                ..fetchPaymentsOfClient(widget.clientId),
      child: BlocBuilder<FetchPaymentsClientsCubit, FetchPaymentsClientsState>(
        builder: (context, state) {
          if (state is FetchPaymentsClientsLoading) {
            return CustomLoading();
          } else if (state is FetchPaymentsClientsError) {
            return CustomErrorMessage(message: state.errMessage);
          } else if (state is FetchPaymentsClientsSuccess) {
            if (state.payments.isEmpty) {
              return CustomEmptyDataMessage(message: "لا يوجد دفعات مسجلة");
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.payments.length,
              itemBuilder: (context, index) {
                final debt = state.payments[index];
                return PaymentItemCard(paymentEntity: debt);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
