import 'package:debt_managment_app/features/clientes/presentation/cubits/fetch%20clients/fetch_clients_cubit.dart';
import 'package:debt_managment_app/features/home/presentation/cubits/cubit/home_view_cubit.dart';
import 'package:debt_managment_app/features/main/presntation/cubits/nav_bar/nav_bar_cubit.dart';
import 'package:debt_managment_app/features/transactions/presentation/cubits/cubit/fetch_all_transactions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BottomSheetListTile.dart';
import 'addclientBottomSheet.dart';
import 'adddebtBottomSheet.dart';
import 'addpaymentBottomSheet.dart';

Future<dynamic> floatActionButtonBottomSheet(BuildContext parentContext) {
  return showModalBottomSheet(
    context: parentContext,
    showDragHandle: true,
    builder: (sheetContext) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetListTile(
            title: "إضافة عميل جديد",
            subtitle: "تسجيل عميل لمتابعة ديونه",
            leadingIcon: Icons.person_add,
            color: Colors.yellow,
            onTap: () async {
              Navigator.pop(sheetContext);
              final result = await addclientBottomSheet(parentContext);
              if (result == true && parentContext.mounted) {
                fetchData(parentContext);
              }
            },
          ),
          BottomSheetListTile(
            title: "إضافة دين جديد",
            subtitle: "تسجيل دين جديد لعميل",
            leadingIcon: Icons.sync_alt,
            color: Colors.red,
            onTap: () async {
              Navigator.pop(sheetContext);
              final result = await adddebtBottomSheet(parentContext);
              if (result == true && parentContext.mounted) {
                fetchData(parentContext);
              }
            },
          ),
          BottomSheetListTile(
            title: "إضافة دفعة جديدة",
            subtitle: "تسجيل دفعة جديدة لعميل",
            leadingIcon: Icons.monetization_on,
            color: Colors.green,
            onTap: () async {
              Navigator.pop(sheetContext);
              final result = await addpaymentBottomSheet(parentContext);
              if (result == true && parentContext.mounted) {
                fetchData(parentContext);
              }
            },
          ),
        ],
      );
    },
  );
}

void fetchData(BuildContext context) {
  final navIndex = context.read<NavBarCubit>().currentIndex;

  if (navIndex == 0) {
    context.read<HomeViewCubit>().getHomeView();
  } else if (navIndex == 1) {
    final fetchClientsCubit = context.read<FetchClientsCubit>();
    fetchClientsCubit.fetchClients(category: fetchClientsCubit.currentCategory);
  } else if (navIndex == 2) {
    final fetchAllTransactionsCubit = context.read<FetchAllTransactionsCubit>();
    fetchAllTransactionsCubit.getAllTransactions(
      category: fetchAllTransactionsCubit.currentCategory,
    );
  }
}
