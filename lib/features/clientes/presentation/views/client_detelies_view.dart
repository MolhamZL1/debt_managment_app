import 'package:flutter/material.dart';

import 'widgets/Client_Detelies_View_Body.dart';

class ClientDeteliesView extends StatelessWidget {
  const ClientDeteliesView({super.key});
 static const routename = "clientDetelies";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
              title: Text(
                "تفاصيل العميل",

              ),
              centerTitle: false,
            ),
      body: ClientDeteliesViewBody(),
    );
  }
}