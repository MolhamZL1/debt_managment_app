import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubit/fetch_all_transactions_cubit.dart';
import 'widgets/Transaction_View_body.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  @override
  void initState() {
    super.initState();
    context.read<FetchAllTransactionsCubit>().getAllTransactions(
      category: "all",
    );
  }

  @override
  Widget build(BuildContext context) {
    return TransactionViewBody();
  }
}
