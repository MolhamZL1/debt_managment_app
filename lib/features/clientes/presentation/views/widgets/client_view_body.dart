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

  bool _onScroll(ScrollNotification notification, BuildContext context) {
    final reachedThreshold =
        notification.metrics.pixels >=
        notification.metrics.maxScrollExtent - 200;

    if (reachedThreshold) {
      context.read<FetchClientsCubit>().fetchMoreClients();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) => _onScroll(notification, context),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: HeaderClientsSection()),
          BlocBuilder<FetchClientsCubit, FetchClientsState>(
            builder: (context, state) {
              if (state is FetchClientsLoading) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: CustomLoading(),
                );
              } else if (state is FetchClientsError) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: CustomErrorMessage(
                    message: state.failure,
                    onReload:
                        () => context.read<FetchClientsCubit>().fetchClients(
                          category: "all",
                        ),
                  ),
                );
              } else if (state is FetchClientsDataState) {
                if (state.clients.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: CustomEmptyDataMessage(message: 'لا يوجد عملاء'),
                  );
                }

                return SliverMainAxisGroup(
                  slivers: [
                    ClientsList(clients: state.clients),
                    if (state is FetchClientsLoadingMore)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    if (state is FetchClientsLoadMoreError)
                      SliverToBoxAdapter(
                        child: Center(
                          child: TextButton(
                            onPressed:
                                () =>
                                    context
                                        .read<FetchClientsCubit>()
                                        .fetchMoreClients(),
                            child: const Text('إعادة المحاولة'),
                          ),
                        ),
                      ),
                  ],
                );
              } else {
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              }
            },
          ),
        ],
      ),
    );
  }
}
