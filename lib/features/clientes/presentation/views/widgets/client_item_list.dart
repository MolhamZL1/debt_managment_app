import 'package:debt_managment_app/features/clientes/domain/entities/client_entity.dart';
import 'package:debt_managment_app/features/clientes/presentation/views/client_detelies_view.dart';
import 'package:flutter/material.dart';

class ClientItemList extends StatelessWidget {
  final ClientEntity clientEntity;

  const ClientItemList({super.key, required this.clientEntity});

  @override
  Widget build(BuildContext context) {
    final balanceColor =
        clientEntity.isDebt() ? Colors.red[100] : Colors.green[100];
    final textbalanceColor = clientEntity.isDebt() ? Colors.red : Colors.green;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(
            context,
            ClientDeteliesView.routename,
            arguments: {"id": clientEntity.id, "name": clientEntity.name},
          );
        },
        contentPadding: const EdgeInsets.all(12),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            clientEntity.name,
            style: TextTheme.of(
              context,
            ).titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.phone_outlined, size: 16),
                Text(
                  clientEntity.phoneNumber ?? "غير معروف",
                  style: TextStyle(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? null
                            : Colors.black54,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16),
                Text(
                  clientEntity.address ?? "غير معروف",
                  style: TextStyle(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? null
                            : Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              "آخر حركة: ${clientEntity.lastTransaction ?? "لا يوجد بعد"}",
              style: TextStyle(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? null
                        : Colors.black54,
              ),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: balanceColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "${clientEntity.amount.abs()} ر.س ${clientEntity.isDebt() ? "دين" : "رصيد"}",
            style: TextStyle(
              color: textbalanceColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
