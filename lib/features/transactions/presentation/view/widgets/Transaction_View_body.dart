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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: HeaderTransactionSection()),
        BlocBuilder<FetchAllTransactionsCubit, FetchAllTransactionsState>(
          builder: (context, state) {
            if (state is FetchAllTransactionsLoading) {
              return const SliverFillRemaining(
                hasScrollBody: false,
                child: CustomLoading(),
              );
            } else if (state is FetchAllTransactionsIFailure) {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: CustomErrorMessage(message: state.errMessage),
              );
            } else if (state is FetchAllTransactionsSuccess) {
              if (state.transactions.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: CustomEmptyDataMessage(message: 'لا يوجد تحويلات'),
                );
              } else {
                return TransactionsList(transactions: state.transactions);
              }
            } else {
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            }
          },
        ),
      ],
    );
  }
}
