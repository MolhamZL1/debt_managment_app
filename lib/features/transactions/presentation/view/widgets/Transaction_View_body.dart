import 'package:flutter/material.dart';

import 'Transaction_Item.dart';
import 'transaction_filtr.dart';

class TransactionViewBody extends StatelessWidget {
  const TransactionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionSearchFilterSection(),
        Expanded(child: TransactionItem()),
      ],
    );
  }
}
