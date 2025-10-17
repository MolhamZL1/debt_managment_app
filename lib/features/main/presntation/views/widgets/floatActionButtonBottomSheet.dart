import 'package:flutter/material.dart';

import 'BottomSheetListTile.dart';
import 'addclientBottomSheet.dart';
import 'adddebtBottomSheet.dart';
import 'addpaymentBottomSheet.dart';

Future<dynamic> floatActionButtonBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetListTile(
            title: "إضافة عميل جديد",
            subtitle: "تسجيل عميل لمتابعة ديونه",
            leadingIcon: Icons.person_add,
            color: Colors.yellow,
            onTap: () {
              Navigator.pop(context);
              addclientBottomSheet(context);
            },
          ),
          BottomSheetListTile(
            title: "إضافة دين جديد",
            subtitle: "تسجيل دين جديد لعميل",
            leadingIcon: Icons.sync_alt,
            color: Colors.red,
            onTap: () {
              Navigator.pop(context);
              adddebtBottomSheet(context);
            },
          ),
          BottomSheetListTile(
            title: "إضافة دفعة جديدة",
            subtitle: "تسجيل دفعة جديدة لعميل",
            leadingIcon: Icons.monetization_on,
            color: Colors.green,
            onTap: () {
              Navigator.pop(context);
              addpaymentBottomSheet(context);
            },
          ),
        ],
      );
    },
  );
}
