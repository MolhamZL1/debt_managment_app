import 'package:debt_managment_app/core/theme/app_text_styles.dart';
import 'package:debt_managment_app/core/utils/currency_formatter.dart';
import 'package:debt_managment_app/features/clientes/domain/entities/client_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../generated/l10n.dart';

class ClientStatus extends StatelessWidget {
  final ClientEntity clientEntity;

  const ClientStatus({super.key, required this.clientEntity});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color:
                clientEntity.isDebt()
                    ? AppColors.error.withAlpha(50)
                    : AppColors.success.withAlpha(50),
            borderRadius: BorderRadius.circular(16),
          ),
          child:
              clientEntity.isDebt()
                  ? Text(
                    l10n.indebted,
                    style: const TextStyle(color: AppColors.error),
                  )
                  : Text(
                    l10n.notIndebted,
                    style: TextStyle(color: AppColors.primary),
                  ),
        ),
        Spacer(),
        clientEntity.isDebt()
            ? _item(
              l10n.debts,
              formatCurrency(context, clientEntity.amount.abs()),
              color: Color(0xFFE11D48),
            )
            : _item(
              l10n.balance,
              formatCurrency(context, clientEntity.amount.abs()),
              color: Colors.green,
            ),
      ],
    );
  }

  Widget _item(String title, String value, {Color? color}) {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: AppTextStyles.titleMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(title),
      ],
    );
  }
}
