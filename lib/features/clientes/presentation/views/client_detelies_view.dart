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
      appBar: AppBar(title: Text(clientEntity.name), centerTitle: false),
      body: ClientDeteliesViewBody(clientEntity: clientEntity),
    );
  }
}
