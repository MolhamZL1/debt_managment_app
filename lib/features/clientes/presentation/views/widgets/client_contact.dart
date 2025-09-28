import 'package:flutter/material.dart';

import 'contact_card.dart';

class ClientContact extends StatefulWidget {
  const ClientContact({super.key});

  @override
  State<ClientContact> createState() => _ClientContactState();
}

class _ClientContactState extends State<ClientContact> {
  final List<Contact> contacts = [
    Contact(
      name: "أحمد محمد",
      phone: "+966501234567",
      address: "الرياض، حي الريس",
      lastTransaction: "1445/07/23 هـ",
      balance: -5000,
    ),
    Contact(
      name: "سارة أحمد",
      phone: "+966501111111",
      address: "جدة",
      lastTransaction: "1445/07/28 هـ",
      balance: -1200,
    ),
    Contact(
      name: "فاطمة علي",
      phone: "+966507654321",
      address: "مكة",
      lastTransaction: "1445/07/25 هـ",
      balance: 500,
    ),
  ];
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ContactCardWidget(contact: contacts[index]);
        },
      ),
    );
  }
}
