import 'package:debt_managment_app/features/clientes/domain/repo/clientes_repo.dart';
import 'package:debt_managment_app/features/clientes/presentation/cubits/fetch%20client/fetch_client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../../../core/widgets/CustomErrorMessage.dart';
import '../../../../core/widgets/CustomLoading.dart';
import 'widgets/Client_Detelies_View_Body.dart';

class ClientDeteliesView extends StatelessWidget {
  const ClientDeteliesView({
    super.key,
    required this.clinetId,
    required this.name,
  });
  static const routename = "clientDetelies";
  final int clinetId;
  final String name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              FetchClientCubit(getIt.get<ClientesRepo>())
                ..fetchClient(clinetId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
          centerTitle: false,
          actions: [
            // IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
            // IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outlined)),
          ],
        ),
        body: BlocBuilder<FetchClientCubit, FetchClientState>(
          builder: (context, state) {
            if (state is FetchClientLoading) {
              return CustomLoading();
            } else if (state is FetchClientError) {
              return CustomErrorMessage(message: state.message);
            } else if (state is FetchClientSuccess) {
              return ClientDeteliesViewBody(clientEntity: state.clientEntity);
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
