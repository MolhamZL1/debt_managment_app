import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_serch_text_faild.dart';
import 'client_filter.dart';

class SearchFilterSection extends StatefulWidget {


  const SearchFilterSection({
    super.key,
  
  });

  @override
  State<SearchFilterSection> createState() => _SearchFilterSectionState();
}

class _SearchFilterSectionState extends State<SearchFilterSection> {
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
        CustomSerchTextFaild(hintText: "البحث بالاسم أو رقم الهاتف..."),
        FilterChipsWidget(

          selectedIndex: selectedFilter,
          onSelected: (index) {
            setState(() {
              selectedFilter = index;
            });
          },
           filters: ["الكل", "مدين", "متأخر", "صافي"],
        ),
      ],
    )
    );
  }
}
