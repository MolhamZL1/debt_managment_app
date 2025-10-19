import 'package:debt_managment_app/features/transactions/domain/entities/transaction_entity.dart';
import 'package:flutter/material.dart';

import '../../../../clientes/presentation/views/client_detelies_view.dart';

class TransactionItemCard extends StatelessWidget {
  const TransactionItemCard({super.key, required this.transactionEntity});
  final TransactionEntity transactionEntity;

  @override
  Widget build(BuildContext context) {
    return transactionEntity.isDebt
        ? TransactionDebtItem(tx: transactionEntity)
        : TransactionPaymentItem(tx: transactionEntity);
  }
}

class TransactionDebtItem extends StatelessWidget {
  const TransactionDebtItem({super.key, required this.tx});

  final TransactionEntity tx;

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFFFEBEE);
    const fg = Color(0xFFC62828);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(
            context,
            ClientDeteliesView.routename,
            arguments: {"id": tx.clientId, "name": tx.clientName},
          );
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: const CircleAvatar(
          backgroundColor: bg,
          child: Icon(Icons.arrow_upward, color: fg),
        ),
        title: Text(
          tx.clientName,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tx.date,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(tx.description ?? "", style: const TextStyle(fontSize: 12)),
          ],
        ),
        trailing: Chip(
          backgroundColor: bg,
          label: Text(
            '${tx.amount}  دين',
            style: TextStyle(
              color: fg,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionPaymentItem extends StatelessWidget {
  const TransactionPaymentItem({super.key, required this.tx});

  final TransactionEntity tx;

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFE8F5E9);
    const fg = Color(0xFF2E7D32);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(
            context,
            ClientDeteliesView.routename,
            arguments: {"id": tx.clientId, "name": tx.clientName},
          );
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: const CircleAvatar(
          backgroundColor: bg,
          child: Icon(Icons.arrow_downward, color: fg),
        ),
        title: Text(
          tx.clientName,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tx.date,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(tx.description ?? "", style: const TextStyle(fontSize: 12)),
          ],
        ),
        trailing: Chip(
          backgroundColor: bg,
          label: Text(
            '${tx.amount}'
            " "
            "دفعة",
            style: TextStyle(
              color: fg,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
