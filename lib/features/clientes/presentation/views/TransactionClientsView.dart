import 'package:debt_managment_app/core/entities/debt_entity.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/transaction_client_repo.dart';
import 'package:debt_managment_app/features/clientes/presentation/cubits/fetch%20transaction%20client/fetch_transaction_client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../cubits/fetch debts client/fetch_debts_client_cubit.dart';
import 'widgets/Debt_Item_Card.dart';
import 'widgets/client_view_body.dart';
import 'widgets/payment_item_card.dart';

class TransactionClientsView extends StatefulWidget {
  const TransactionClientsView({super.key, required this.clientId});
  final int clientId;

  @override
  State<TransactionClientsView> createState() => _TransactionClientsViewState();
}

class _TransactionClientsViewState extends State<TransactionClientsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create:
          (context) =>
              FetchTransactionClientCubit(getIt.get<TransactionClientRepo>())
                ..fetchTransactionClient(widget.clientId),
      child:
          BlocBuilder<FetchTransactionClientCubit, FetchTransactionClientState>(
            builder: (context, state) {
              if (state is FetchDebtsClientLoading) {
                return CustomLoading();
              } else if (state is FetchTransactionClientError) {
                return CustomErrorMessage(message: state.errMessage);
              } else if (state is FetchTransactionClientSuccess) {
                if (state.transactions.isEmpty) {
                  return CustomEmptyDataMessage(
                    message: "لا يوجد ديون او دفعات مسجلة",
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: state.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = state.transactions[index];
                    if (transaction is DebtEntity) {
                      return DebtItemCard(
                        debtEntity: transaction,
                        onDelete: () {},
                        onEdit: () {},
                      );
                    } else {
                      return PaymentItemCard(paymentEntity: transaction);
                    }
                  },
                );
              }
              return const SizedBox();
            },
          ),
    );
  }
}
