import 'package:debt_managment_app/core/services/get_it_service.dart';
import 'package:debt_managment_app/features/clientes/presentation/views/widgets/client_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main/domain/repo/ClientSearchDropDown_repo.dart';
import '../cubits/fetch clients/fetch_clients_cubit.dart';
import '../cubits/search/search_cubit.dart';

class ClientView extends StatefulWidget {
  const ClientView({super.key});

  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  @override
  void initState() {
    super.initState();
    context.read<FetchClientsCubit>().fetchClients(category: "all");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(getIt.get<ClientSearchDropDownRepo>()),

      child: ClientViewBody(),
    );
  }
}
