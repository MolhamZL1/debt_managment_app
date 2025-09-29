import 'package:flutter/material.dart';

import 'Search_Filter_Section.dart';
import 'client_contact.dart';

class ClientViewBody extends StatelessWidget {
  const ClientViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: HeaderClientsSection()),
        ClientContact(),
      ],
    );
  }
}
