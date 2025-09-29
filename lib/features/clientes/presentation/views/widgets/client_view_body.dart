import 'package:flutter/material.dart';

import 'HeaderClientsSection.dart';
import 'clients_list.dart';

class ClientViewBody extends StatelessWidget {
  const ClientViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: HeaderClientsSection()),
        ClientsList(),
      ],
    );
  }
}
