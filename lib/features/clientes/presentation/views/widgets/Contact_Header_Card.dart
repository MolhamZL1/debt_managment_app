import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../core/functions/call_number.dart';
import '../../../domain/entities/client_entity.dart';
import 'Stats_Row.dart';

class ClientDetailsHeaderCard extends StatelessWidget {
  const ClientDetailsHeaderCard({super.key, required this.clientEntity});
  final ClientEntity clientEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.phone_outlined, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          clientEntity.phoneNumber ?? "غير معروف",
                          textDirection: TextDirection.ltr,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 16),
                        const SizedBox(width: 6),
                        Text(clientEntity.address ?? "غير معروف"),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: clientEntity.phoneNumber != null,
                child: GestureDetector(
                  onTap: () {
                    callNumber(context, clientEntity.phoneNumber!);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withAlpha(50),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      "اتصال",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 40),
          ClientStatus(balance: -5),
        ],
      ),
    );
  }
}
