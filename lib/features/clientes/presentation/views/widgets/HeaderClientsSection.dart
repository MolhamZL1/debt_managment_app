import 'package:debt_managment_app/features/clientes/presentation/cubits/fetch%20clients/fetch_clients_cubit.dart';
import 'package:debt_managment_app/features/clientes/presentation/cubits/search/search_cubit.dart';
import 'package:debt_managment_app/features/clientes/presentation/views/client_detelies_view.dart';
import 'package:debt_managment_app/features/main/domain/entities/ClientSearchDropDownEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/category_list.dart';
import 'ClientSearchDelegate.dart';

class HeaderClientsSection extends StatelessWidget {
  const HeaderClientsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              readOnly: true,
              onTap: () async {
                ClientSearchDropDownEntity clientSearchDropDownEntity =
                    await showSearch(
                      context: context,
                      delegate: ClientSearchDelegate(
                        cubit: context.read<SearchCubit>(),
                      ),
                    );
                Navigator.pushNamed(
                  context,
                  ClientDeteliesView.routename,
                  arguments: {
                    'id': clientSearchDropDownEntity.id,
                    'name': clientSearchDropDownEntity.name,
                  },
                );
              },
              decoration: InputDecoration(
                hintText: 'البحث بالاسم أو رقم الهاتف...',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: 52,
            child: CategoriesList(
              categories: ["الكل", "مدين", "متأخر", "صافي"],
              onCategorySelected: (selectedIndex) {
                context.read<FetchClientsCubit>().fetchClients(
                  category:
                      selectedIndex == 0
                          ? "all"
                          : selectedIndex == 1
                          ? "debt"
                          : selectedIndex == 2
                          ? "late"
                          : "clear",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
