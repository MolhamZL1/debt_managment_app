import 'package:debt_managment_app/core/services/get_it_service.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/clientes_repo.dart';
import 'package:debt_managment_app/features/clientes/presentation/cubits/fetch%20clients/fetch_clients_cubit.dart';
import 'package:debt_managment_app/features/clientes/presentation/views/widgets/client_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientView extends StatelessWidget {
  const ClientView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              FetchClientsCubit(getIt.get<ClientesRepo>())..fetchClients(),
      child: ClientViewBody(),
    );
  }
}
