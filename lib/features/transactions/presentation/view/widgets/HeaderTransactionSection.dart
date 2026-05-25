import 'package:debt_managment_app/features/transactions/presentation/cubits/cubit/fetch_all_transactions_cubit.dart';
import 'package:debt_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/category_list.dart';

class HeaderTransactionSection extends StatelessWidget {
  const HeaderTransactionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 52,
            child: CategoriesList(
              categories: [l10n.all, l10n.debts, l10n.payments],
              onCategorySelected: (selectedIndex) {
                context.read<FetchAllTransactionsCubit>().getAllTransactions(
                  category:
                      selectedIndex == 0
                          ? "all"
                          : selectedIndex == 1
                          ? "debt"
                          : "payment",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
