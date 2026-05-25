import 'package:debt_managment_app/core/services/get_it_service.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/debt_client_repo.dart';
import 'package:debt_managment_app/features/clientes/presentation/cubits/fetch%20debts%20client/fetch_debts_client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/CustomEmptyDataMessageCustomEmptyDataMessage.dart';
import '../../../../core/widgets/CustomErrorMessage.dart';
import '../../../../core/widgets/CustomLoading.dart';
import '../../../../generated/l10n.dart';
import 'widgets/Debt_Item_Card.dart';

class DebtsClientView extends StatefulWidget {
  const DebtsClientView({super.key, required this.clientId});
  final int clientId;

  @override
  State<DebtsClientView> createState() => _DebtsClientViewState();
}

class _DebtsClientViewState extends State<DebtsClientView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _onScroll(ScrollNotification notification, BuildContext context) {
    final reachedThreshold =
        notification.metrics.pixels >=
        notification.metrics.maxScrollExtent - 200;

    if (reachedThreshold) {
      context.read<FetchDebtsClientCubit>().fetchMoreDebtsClient();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = S.of(context);
    return BlocProvider(
      create:
          (context) =>
              FetchDebtsClientCubit(getIt.get<DebtClientRepo>())
                ..fetchDebtsClient(widget.clientId),
      child: BlocBuilder<FetchDebtsClientCubit, FetchDebtsClientState>(
        builder: (context, state) {
          if (state is FetchDebtsClientLoading) {
            return CustomLoading();
          } else if (state is FetchDebtsClientError) {
            return CustomErrorMessage(
              message: state.errMessage,
              onReload:
                  () => context.read<FetchDebtsClientCubit>().fetchDebtsClient(
                    widget.clientId,
                  ),
            );
          } else if (state is FetchDebtsClientDataState) {
            if (state.debts.isEmpty) {
              return CustomEmptyDataMessage(message: l10n.noRegisteredDebts);
            }

            final showFooter =
                state is FetchDebtsClientLoadingMore ||
                state is FetchDebtsClientLoadMoreError;

            return NotificationListener<ScrollNotification>(
              onNotification:
                  (notification) => _onScroll(notification, context),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: state.debts.length + (showFooter ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < state.debts.length) {
                    final debt = state.debts[index];
                    return DebtItemCard(
                      debtEntity: debt,
                      onDelete: () {},
                      onEdit: () {},
                    );
                  }

                  if (state is FetchDebtsClientLoadingMore) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is FetchDebtsClientLoadMoreError) {
                    return Center(
                      child: TextButton(
                        onPressed:
                            () =>
                                context
                                    .read<FetchDebtsClientCubit>()
                                    .fetchMoreDebtsClient(),
                        child: Text(l10n.retry),
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
