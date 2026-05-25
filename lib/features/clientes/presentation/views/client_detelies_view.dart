import 'package:debt_managment_app/features/clientes/domain/repo/clientes_repo.dart';
import 'package:debt_managment_app/features/clientes/presentation/cubits/delete%20client/delete_client_cubit.dart';
import 'package:debt_managment_app/features/clientes/presentation/cubits/fetch%20client/fetch_client_cubit.dart';
import 'package:debt_managment_app/features/main/presntation/views/main_view.dart';
import 'package:debt_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../../../core/utils/show_err_dialog.dart';
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

  Future<void> _confirmAndDelete(BuildContext context) async {
    final l10n = S.of(context);
    final isConfirmed =
        await showDialog<bool>(
          context: context,
          builder:
              (dialogContext) => AlertDialog(
                title: Text(l10n.confirmDelete),
                content: Text(l10n.deleteClientQuestion),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    child: Text(l10n.cancel),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(dialogContext, true),
                    child: Text(l10n.delete),
                  ),
                ],
              ),
        ) ??
        false;

    if (!isConfirmed || !context.mounted) {
      return;
    }

    context.read<DeleteClientCubit>().deleteClient(clinetId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  FetchClientCubit(getIt.get<ClientesRepo>())
                    ..fetchClient(clinetId),
        ),
        BlocProvider(
          create: (context) => DeleteClientCubit(getIt.get<ClientesRepo>()),
        ),
      ],
      child: BlocConsumer<DeleteClientCubit, DeleteClientState>(
        listener: (context, state) {
          final l10n = S.of(context);
          if (state is DeleteClientError) {
            showerrorDialog(
              context: context,
              title: l10n.genericError,
              description: state.message,
            );
          } else if (state is DeleteClientSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.clientDeletedSuccessfully)),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              MainView.routename,
              (route) => false,
            );
          }
        },
        builder: (context, deleteState) {
          final isDeleting = deleteState is DeleteClientLoading;

          return Scaffold(
            appBar: AppBar(
              title: Text(name),
              centerTitle: false,
              actions: [
                IconButton(
                  onPressed:
                      isDeleting ? null : () => _confirmAndDelete(context),
                  icon:
                      isDeleting
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Icon(Icons.delete_outlined),
                ),
              ],
            ),
            body: Stack(
              children: [
                AbsorbPointer(
                  absorbing: isDeleting,
                  child: BlocBuilder<FetchClientCubit, FetchClientState>(
                    builder: (context, state) {
                      if (state is FetchClientLoading) {
                        return CustomLoading();
                      } else if (state is FetchClientError) {
                        return CustomErrorMessage(
                          message: state.message,
                          onReload:
                              () => context
                                  .read<FetchClientCubit>()
                                  .fetchClient(clinetId),
                        );
                      } else if (state is FetchClientSuccess) {
                        return ClientDeteliesViewBody(
                          clientEntity: state.clientEntity,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
                if (isDeleting)
                  Positioned.fill(
                    child: ColoredBox(
                      color: Colors.black26,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
