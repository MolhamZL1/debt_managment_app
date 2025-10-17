import 'package:debt_managment_app/core/services/get_it_service.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/debt_client_repo.dart';
import 'package:debt_managment_app/features/clientes/presentation/cubits/fetch%20debts%20client/fetch_debts_client_cubit.dart';
import 'package:debt_managment_app/features/clientes/presentation/views/widgets/client_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/Debt_Item_Card.dart';

class DebtsClientView extends StatefulWidget {
  const DebtsClientView({super.key, required this.clientId});
  final int clientId;

  @override
  State<DebtsClientView> createState() => _DebtsClientViewState();
}

class _DebtsClientViewState extends State<DebtsClientView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create:
          (context) =>
              FetchDebtsClientCubit(getIt.get<DebtClientRepo>())
                ..fetchDebtsClient(widget.clientId),
      child: BlocBuilder<FetchDebtsClientCubit, FetchDebtsClientState>(
        builder: (context, state) {
          if (state is FetchDebtsClientLoading) {
            return CustomLoading();
          } else if (state is FetchDebtsClientError) {
            return CustomErrorMessage(message: state.errMessage);
          } else if (state is FetchDebtsClientSuccess) {
            if (state.debts.isEmpty) {
              return CustomEmptyDataMessage(message: "لا يوجد ديون مسجلة");
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.debts.length,
              itemBuilder: (context, index) {
                final debt = state.debts[index];
                return DebtItemCard(
                  debtEntity: debt,
                  onDelete: () {},
                  onEdit: () {},
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
