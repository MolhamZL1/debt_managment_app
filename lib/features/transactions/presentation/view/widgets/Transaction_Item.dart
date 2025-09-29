import 'package:flutter/material.dart';

import 'Transaction_Item_Card.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
  children:  [
    TransactionItemCard(
      clientName: "أحمد محمد",
      date: "1445/07/28 هـ",
      description: "تحويل بنكي",
      amount: 2000,
      isPayment: true,
    ),
    TransactionItemCard(
      clientName: "فاطمة علي",
      date: "1445/07/27 هـ",
      description: "دفعة نقدية",
      amount: 3000,
      isPayment: true,
    ),
    TransactionItemCard(
      clientName: "أحمد محمد",
      date: "1445/07/23 هـ",
      description: "",
      amount: 5000,
      isPayment: false,
      dueDate: "1445/08/05 هـ",
      invoiceNo: "1234",
    ),
  ],
)
;
  }
}