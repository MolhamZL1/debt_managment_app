import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_serch_text_faild.dart';
import '../../../../clientes/presentation/views/widgets/client_filter.dart';

class TransactionSearchFilterSection extends StatefulWidget {
  const TransactionSearchFilterSection({super.key});

  @override
  State<TransactionSearchFilterSection> createState() => _TransactionSearchFilterSectionState();
}

class _TransactionSearchFilterSectionState extends State<TransactionSearchFilterSection> {
  int selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
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
          CustomSerchTextFaild(hintText: "البحث بالحركات..."),
          FilterChipsWidget(
            selectedIndex: selectedFilter,
            onSelected: (index) {
              setState(() {
                selectedFilter = index;
              });
            },
            filters: ["الكل", "ديون", "دفعات"],
          ),
        ],
      ),
    );
  }

}