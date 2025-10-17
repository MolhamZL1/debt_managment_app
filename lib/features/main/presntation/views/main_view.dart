import 'package:debt_managment_app/core/utils/app_images.dart';
import 'package:debt_managment_app/core/utils/show_err_dialog.dart';
import 'package:debt_managment_app/features/clientes/presentation/views/client_view.dart';
import 'package:debt_managment_app/features/home/presentation/views/home_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/settings_view.dart';
import 'package:debt_managment_app/features/transactions/presentation/view/transaction_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../../clientes/domain/repo/debt_client_repo.dart';
import '../../../clientes/presentation/cubits/add debt/add_debt_cubit.dart';
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
        BlocProvider(create: (context) => NavBarCubit()),
        BlocProvider(
          create: (context) => AddDebtCubit(getIt.get<DebtClientRepo>()),
        ),
      ],
      child: BlocListener<AddDebtCubit, AddDebtState>(
        listener: (context, state) {
          if (state is AddDebtSuccess) {
            Navigator.pop(context);
          }
          if (state is AddDebtError) {
            Navigator.pop(context);
            showerrorDialog(
              context: context,
              title: "فشل",
              description: state.errMessage,
            );
          }
        },
        child: BlocBuilder<NavBarCubit, int>(
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  floatActionButtonBottomSheet(context);
                },
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                title: Text(
                  ["سجلها", "العملاء", "التحويلات", "الإعدادات"][state],
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(AppImages.imagesAppIcon),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_outlined),
                  ),
                ],
              ),
              bottomNavigationBar: CustomNavBar(),
              body:
                  [
                    HomeView(),
                    ClientView(),
                    TransactionView(),
                    SettingsView(),
                  ][state],
            );
          },
        ),
      ),
    );
  }
}
