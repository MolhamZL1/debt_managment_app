import 'package:debt_managment_app/features/transactions/presentation/cubits/cubit/fetch_all_transactions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/CustomEmptyDataMessageCustomEmptyDataMessage.dart';
import '../../../../../core/widgets/CustomErrorMessage.dart';
import '../../../../../core/widgets/CustomLoading.dart';
import 'HeaderTransactionSection.dart';
import 'TransactionsList.dart';

class TransactionViewBody extends StatelessWidget {
  const TransactionViewBody({super.key});

  bool _onScroll(ScrollNotification notification, BuildContext context) {
    final reachedThreshold =
        notification.metrics.pixels >=
        notification.metrics.maxScrollExtent - 200;

    if (reachedThreshold) {
      context.read<FetchAllTransactionsCubit>().fetchMoreTransactions();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) => _onScroll(notification, context),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: HeaderTransactionSection()),
          BlocBuilder<FetchAllTransactionsCubit, FetchAllTransactionsState>(
            builder: (context, state) {
              if (state is FetchAllTransactionsLoading) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: CustomLoading(),
                );
              } else if (state is FetchAllTransactionsIFailure) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: CustomErrorMessage(
                    message: state.errMessage,
                    onReload:
                        () => context
                            .read<FetchAllTransactionsCubit>()
                            .getAllTransactions(category: "all"),
                  ),
                );
              } else if (state is FetchAllTransactionsDataState) {
                if (state.transactions.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: CustomEmptyDataMessage(message: 'لا يوجد تحويلات'),
                  );
                }

                return SliverMainAxisGroup(
                  slivers: [
                    TransactionsList(transactions: state.transactions),
                    if (state is FetchAllTransactionsLoadingMore)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    if (state is FetchAllTransactionsLoadMoreError)
                      SliverToBoxAdapter(
                        child: Center(
                          child: TextButton(
                            onPressed:
                                () =>
                                    context
                                        .read<FetchAllTransactionsCubit>()
                                        .fetchMoreTransactions(),
                            child: const Text('إعادة المحاولة'),
                          ),
                        ),
                      ),
                  ],
                );
              } else {
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              }
            },
          ),
        ],
      ),
    );
  }
}
