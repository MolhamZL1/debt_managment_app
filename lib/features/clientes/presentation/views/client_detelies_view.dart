import 'package:flutter/material.dart';

import '../../domain/entities/client_entity.dart';
import 'widgets/Client_Detelies_View_Body.dart';

class ClientDeteliesView extends StatelessWidget {
  const ClientDeteliesView({super.key, required this.clientEntity});
  static const routename = "clientDetelies";
  final ClientEntity clientEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clientEntity.name),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outlined)),
        ],
      ),
      body: ClientDeteliesViewBody(clientEntity: clientEntity),
    );
  }
}
