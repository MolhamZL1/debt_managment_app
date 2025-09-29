import 'package:debt_managment_app/features/clientes/domain/entities/client_entity.dart';
import 'package:flutter/material.dart';

import 'client_item_list.dart';

class ClientsList extends StatefulWidget {
  const ClientsList({super.key});

  @override
  State<ClientsList> createState() => _ClientsListState();
}

class _ClientsListState extends State<ClientsList> {
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
