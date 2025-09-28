import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'Segmented_Tabs.dart';
import 'Stats_Row.dart';

class ContactHeaderCard extends StatefulWidget {
  const ContactHeaderCard({super.key});

  @override
  State<ContactHeaderCard> createState() => _ContactHeaderCardState();
}

class _ContactHeaderCardState extends State<ContactHeaderCard> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        // borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.phone, size: 16),
                                const SizedBox(width: 6),
                                Text('+966501234567'),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text('الرياض، حي النرجس'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withAlpha(50),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Text(
                            "اتصال",
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(color: Colors.grey),
                  SizedBox(height: 16),
                  StatsRow(balance: 0, totalPaid: 0, totalDebts: 0),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(color: Colors.grey),
            ),
            SegmentedTabs(
              selectedIndex: selectedTab,
              onTap: (index) {
                setState(() {
                  selectedTab = index;
                });
              },
            ),
            Expanded(
              child: Center(
                child: Text(
                  "المحتوى: ${["الديون", "الدفعات", "كشف الحساب"][selectedTab]}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
