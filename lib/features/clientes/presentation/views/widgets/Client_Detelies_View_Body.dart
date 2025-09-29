import 'package:flutter/material.dart';

import 'Action_Buttons_Row.dart';
import 'Debt_Item_Card.dart';
import 'contact_header_card.dart';

class ClientDeteliesViewBody extends StatelessWidget {
  const ClientDeteliesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContactHeaderCard(),
        ActionButtonsRow(onAddDebt: () {}, onAddPayment: () {}),
        DebtItemCard(
          debt: Debt(
            amount: 5000,
            dueHijri: "1445/07/05 هـ",
            invoiceNo: "1234",
          ),
          onDelete: () {},
          onEdit: () {},
        ),
      ],
    );
  }
}

/* ----------------------- Widgets ----------------------- */
