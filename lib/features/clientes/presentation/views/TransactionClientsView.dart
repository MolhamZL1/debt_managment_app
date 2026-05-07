import 'package:debt_managment_app/core/entities/debt_entity.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/transaction_client_repo.dart';
import 'package:debt_managment_app/features/clientes/presentation/cubits/fetch%20transaction%20client/fetch_transaction_client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../../../core/widgets/CustomEmptyDataMessageCustomEmptyDataMessage.dart';
import '../../../../core/widgets/CustomErrorMessage.dart';
import '../../../../core/widgets/CustomLoading.dart';
import 'widgets/Debt_Item_Card.dart';
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

  bool _onScroll(ScrollNotification notification, BuildContext context) {
    final reachedThreshold =
        notification.metrics.pixels >=
        notification.metrics.maxScrollExtent - 200;

    if (reachedThreshold) {
      context.read<FetchTransactionClientCubit>().fetchMoreTransactionClient();
    }

    return false;
  }

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
              if (state is FetchTransactionClientLoading) {
                return CustomLoading();
              } else if (state is FetchTransactionClientError) {
                return CustomErrorMessage(
                  message: state.errMessage,
                  onReload:
                      () => context
                          .read<FetchTransactionClientCubit>()
                          .fetchTransactionClient(widget.clientId),
                );
              } else if (state is FetchTransactionClientDataState) {
                if (state.transactions.isEmpty) {
                  return CustomEmptyDataMessage(
                    message: "لا يوجد ديون او دفعات مسجلة",
                  );
                }

                final showFooter =
                    state is FetchTransactionClientLoadingMore ||
                    state is FetchTransactionClientLoadMoreError;

                return NotificationListener<ScrollNotification>(
                  onNotification:
                      (notification) => _onScroll(notification, context),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: state.transactions.length + (showFooter ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < state.transactions.length) {
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
                      }

                      if (state is FetchTransactionClientLoadingMore) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (state is FetchTransactionClientLoadMoreError) {
                        return Center(
                          child: TextButton(
                            onPressed:
                                () =>
                                    context
                                        .read<FetchTransactionClientCubit>()
                                        .fetchMoreTransactionClient(),
                            child: const Text('إعادة المحاولة'),
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
    );
  }
}
