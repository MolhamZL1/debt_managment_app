import 'package:debt_managment_app/features/clientes/domain/repo/payment_client_repo.dart';
import 'package:debt_managment_app/features/clientes/presentation/cubits/fetch%20payment%20client/fetch_payments_clients_cubit.dart';
import 'package:debt_managment_app/features/clientes/presentation/views/widgets/payment_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';

import '../../../../core/widgets/CustomEmptyDataMessageCustomEmptyDataMessage.dart';
import '../../../../core/widgets/CustomErrorMessage.dart';
import '../../../../core/widgets/CustomLoading.dart';

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

  bool _onScroll(ScrollNotification notification, BuildContext context) {
    final reachedThreshold =
        notification.metrics.pixels >=
        notification.metrics.maxScrollExtent - 200;

    if (reachedThreshold) {
      context.read<FetchPaymentsClientsCubit>().fetchMorePaymentsOfClient();
    }

    return false;
  }

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
            return CustomErrorMessage(
              message: state.errMessage,
              onReload:
                  () => context
                      .read<FetchPaymentsClientsCubit>()
                      .fetchPaymentsOfClient(widget.clientId),
            );
          } else if (state is FetchPaymentsClientsDataState) {
            if (state.payments.isEmpty) {
              return CustomEmptyDataMessage(message: "لا يوجد دفعات مسجلة");
            }

            final showFooter =
                state is FetchPaymentsClientsLoadingMore ||
                state is FetchPaymentsClientsLoadMoreError;

            return NotificationListener<ScrollNotification>(
              onNotification:
                  (notification) => _onScroll(notification, context),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: state.payments.length + (showFooter ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < state.payments.length) {
                    final payment = state.payments[index];
                    return PaymentItemCard(paymentEntity: payment);
                  }

                  if (state is FetchPaymentsClientsLoadingMore) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is FetchPaymentsClientsLoadMoreError) {
                    return Center(
                      child: TextButton(
                        onPressed:
                            () =>
                                context
                                    .read<FetchPaymentsClientsCubit>()
                                    .fetchMorePaymentsOfClient(),
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
