import 'package:debt_managment_app/core/functions/open_whatsapp.dart';
import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:debt_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../../core/functions/call_number.dart';
import '../../../domain/entities/client_entity.dart';
import 'ClientStatus.dart';

class ClientDetailsHeaderCard extends StatelessWidget {
  const ClientDetailsHeaderCard({super.key, required this.clientEntity});
  final ClientEntity clientEntity;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            clientEntity.phoneNumber ?? l10n.unknown,
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 16),
                          const SizedBox(width: 6),
                          Text(clientEntity.address ?? l10n.unknown),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: clientEntity.phoneNumber != null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
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
                          child: Text(
                            l10n.call,
                            style: const TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          openWhatsApp(context, clientEntity.phoneNumber!);
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
                          child: Text(
                            l10n.whatsapp,
                            style: const TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(height: 40),
            ClientStatus(clientEntity: clientEntity),
          ],
        ),
      ),
    );
  }
}
