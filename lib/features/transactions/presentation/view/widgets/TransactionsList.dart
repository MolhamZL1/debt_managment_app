import 'package:flutter/material.dart';

import '../../../domain/entities/transaction_entity.dart';
import 'Transaction_Item_Card.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key, required this.transactions});
  final List<TransactionEntity> transactions;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return TransactionItemCard(transactionEntity: transactions[index]);
      },
    );
  }
}
