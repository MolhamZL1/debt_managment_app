import 'package:debt_managment_app/core/services/get_it_service.dart';
import 'package:debt_managment_app/features/transactions/presentation/cubits/cubit/fetch_all_transactions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repo/transaction_repo.dart';
import 'widgets/Transaction_View_body.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              FetchAllTransactionsCubit(getIt.get<TransactionRepo>())
                ..getAllTransactions(category: "all"),
      child: TransactionViewBody(),
    );
  }
}
