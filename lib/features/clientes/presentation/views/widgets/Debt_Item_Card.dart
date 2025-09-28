// import 'package:debt_managment_app/features/clientes/presentation/views/widgets/Client_Detelies_View_Body.dart';
// import 'package:flutter/material.dart';

// class DebtItemCard extends StatelessWidget {
//   final Debt debt;
//   final VoidCallback onDelete;

//   const DebtItemCard({super.key, required this.debt, required this.onDelete});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: AppColors.border),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // زر حذف دائري
//           InkWell(
//             onTap: onDelete,
//             child: Container(
//               width: 36,
//               height: 36,
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.border),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.delete_outline,
//                 size: 18,
//                 color: AppColors.danger,
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           const Icon(Icons.receipt_long_outlined, color: AppColors.green),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Color(0xFFFCE7EF),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Text(
//                       "دين • ر.س ${debt.amount.toStringAsFixed(0)}",
//                       style: const TextStyle(color: AppColors.danger),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     _chip("استحقاق: ${debt.dueHijri}"),
//                     const SizedBox(width: 8),
//                     _chip("فاتورة رقم ${debt.invoiceNo}"),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );

// a
//   Widget _chip(String text) => Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//         decoration: BoxDecoration(
//           color: AppColors.lightGrey,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Text(text),
//       );
// }
