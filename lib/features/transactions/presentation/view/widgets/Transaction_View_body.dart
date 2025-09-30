import 'package:flutter/material.dart';

import 'HeaderTransactionSection.dart';
import 'Transaction_Item.dart';

class TransactionViewBody extends StatelessWidget {
  const TransactionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderTransactionSection(),
        Expanded(child: TransactionItem()),
      ],
    );
  }
}
