import 'package:debt_managment_app/features/clientes/domain/entities/client_entity.dart';
import 'package:flutter/material.dart';

import 'client_item_list.dart';

class ClientContact extends StatefulWidget {
  const ClientContact({super.key});

  @override
  State<ClientContact> createState() => _ClientContactState();
}

class _ClientContactState extends State<ClientContact> {
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: clients.length,
      itemBuilder: (context, index) {
        return ClientItemList(clientEntity: clients[index]);
      },
    );
  }
}
