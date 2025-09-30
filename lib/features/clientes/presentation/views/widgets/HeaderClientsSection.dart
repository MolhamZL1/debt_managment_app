import 'package:flutter/material.dart';
import '../../../../../core/widgets/category_list.dart';

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
              onCategorySelected: (selectedIndex) {},
            ),
          ),
        ],
      ),
    );
  }
}
