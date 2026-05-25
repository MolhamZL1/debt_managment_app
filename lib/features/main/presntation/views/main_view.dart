import 'package:debt_managment_app/core/utils/app_images.dart';
import 'package:debt_managment_app/features/clientes/presentation/views/client_view.dart';
import 'package:debt_managment_app/features/home/presentation/views/home_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/settings_view.dart';
import 'package:debt_managment_app/features/transactions/presentation/view/transaction_view.dart';
import 'package:debt_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../../clientes/domain/repo/clientes_repo.dart';
import '../../../clientes/presentation/cubits/fetch clients/fetch_clients_cubit.dart';
import '../../../home/domain/repo/home_view_repo.dart';
import '../../../home/presentation/cubits/cubit/home_view_cubit.dart';
import '../../../transactions/domain/repo/transaction_repo.dart';
import '../../../transactions/presentation/cubits/cubit/fetch_all_transactions_cubit.dart';
import '../cubits/nav_bar/nav_bar_cubit.dart';
import 'widgets/CustomNavBar.dart';
import 'widgets/floatActionButtonBottomSheet.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});
  static const routename = "main";
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchClientsCubit(getIt.get<ClientesRepo>()),
        ),
        BlocProvider(create: (context) => NavBarCubit()),
        BlocProvider(
          create: (context) => HomeViewCubit(getIt.get<HomeViewRepo>()),
        ),
        BlocProvider(
          create:
              (context) =>
                  FetchAllTransactionsCubit(getIt.get<TransactionRepo>()),
        ),
      ],
      child: BlocBuilder<NavBarCubit, int>(
        builder: (context, state) {
          final l10n = S.of(context);
          final titles = [
            l10n.appName,
            l10n.clients,
            l10n.transactions,
            l10n.settings,
          ];

          return SafeArea(
            top: false,
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  floatActionButtonBottomSheet(context);
                },
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                title: Text(titles[state]),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(AppImages.imagesAppIcon),
                ),
                actions: [
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.notifications_outlined),
                  // ),
                ],
              ),
              bottomNavigationBar: const CustomNavBar(),
              body:
                  const [
                    HomeView(),
                    ClientView(),
                    TransactionView(),
                    SettingsView(),
                  ][state],
            ),
          );
        },
      ),
    );
  }
}
