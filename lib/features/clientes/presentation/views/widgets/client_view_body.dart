import 'package:flutter/material.dart';

import 'Search_Filter_Section.dart';
import 'client_contact.dart';

class ClientViewBody extends StatefulWidget {
  const ClientViewBody({super.key});

  @override
  State<ClientViewBody> createState() => _ClientViewBodyState();
}

class _ClientViewBodyState extends State<ClientViewBody> {
  int selectedFilter = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [SearchFilterSection(), ClientContact()]);
  }
}
