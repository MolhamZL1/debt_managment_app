import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:debt_managment_app/features/clientes/presentation/views/client_view.dart';
import 'package:debt_managment_app/features/home/presentation/views/home_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/settings_view.dart';
import 'package:debt_managment_app/features/transactions/presentation/view/transaction_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/nav_bar/nav_bar_cubit.dart';
import 'widgets/CustomNavBar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});
  static const routename = "main";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, int>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
              title: Text(
                ["الصفحة الرئيسية", "العملاء", "التحويلات", "الاعدادات"][state],
              ),
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
    );
  }
}
