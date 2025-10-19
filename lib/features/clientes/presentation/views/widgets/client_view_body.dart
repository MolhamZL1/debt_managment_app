import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/CustomEmptyDataMessageCustomEmptyDataMessage.dart';
import '../../../../../core/widgets/CustomErrorMessage.dart';
import '../../../../../core/widgets/CustomLoading.dart';
import '../../cubits/fetch clients/fetch_clients_cubit.dart';
import 'HeaderClientsSection.dart';
import 'clients_list.dart';

class ClientViewBody extends StatelessWidget {
  const ClientViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: HeaderClientsSection()),
        BlocBuilder<FetchClientsCubit, FetchClientsState>(
          builder: (context, state) {
            if (state is FetchClientsLoading) {
              return const SliverFillRemaining(
                hasScrollBody: false,
                child: CustomLoading(),
              );
            } else if (state is FetchClientsError) {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: CustomErrorMessage(message: state.failure),
              );
            } else if (state is FetchClientsSuccess) {
              if (state.clients.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: CustomEmptyDataMessage(message: 'لا يوجد عملاء'),
                );
              } else {
                return ClientsList(clients: state.clients);
              }
            } else {
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            }
          },
        ),
      ],
    );
  }
}
