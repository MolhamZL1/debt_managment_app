import 'package:debt_managment_app/core/theme/app_text_styles.dart';
import 'package:debt_managment_app/features/clientes/presentation/views/client_detelies_view.dart';
import 'package:flutter/material.dart';

class ContactCardWidget extends StatelessWidget {
  final Contact contact;

  const ContactCardWidget({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final isDebt = contact.balance < 0;
    final balanceColor = isDebt ? Colors.red[100] : Colors.green[100];
    final textbalanceColor = isDebt ? Colors.red : Colors.green;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Text(
          contact.name,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contact.phone),
            Text(contact.address),
            Text("آخر حركة: ${contact.lastTransaction}"),
          ],
        ),
        trailing: GestureDetector(
          onTap: () {
            // TODO: navigate to contact details
            Navigator.pushNamed(context, ClientDeteliesView.routename);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: balanceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "${contact.balance.abs()} رس",
              style: TextStyle(color: textbalanceColor),
            ),
          ),
        ),
      ),
    );
  }
}

class Contact {
  final String name;
  final String phone;
  final String address;
  final String lastTransaction;
  final double balance;

  Contact({
    required this.name,
    required this.phone,
    required this.address,
    required this.lastTransaction,
    required this.balance,
  });
}
