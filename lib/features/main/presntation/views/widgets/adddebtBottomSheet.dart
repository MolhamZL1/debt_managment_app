import 'package:debt_managment_app/core/functions/custom_validator.dart';
import 'package:debt_managment_app/core/utils/show_err_dialog.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/debt_client_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/services/get_it_service.dart';
import '../../../../../core/cubits/add debt/add_debt_cubit.dart';
import '../../../../../core/utils/custom_snack_bar.dart';
import '../../../../settings/presentation/view/widgets/TextHeaderSettings.dart';
import '../../../domain/entities/ClientSearchDropDownEntity.dart';
import 'ClientSearchField.dart';

Future<dynamic> adddebtBottomSheet(BuildContext context) {
  final formKey = GlobalKey<FormBuilderState>();

  return showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (ctx) {
      final bottomInset = MediaQuery.of(ctx).viewInsets.bottom;
      return BlocProvider(
        create: (context) => AddDebtCubit(getIt.get<DebtClientRepo>()),
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: FormBuilder(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "إضافة دين جديد",
                    textAlign: TextAlign.start,
                    style: Theme.of(ctx).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 24),

                  const TextHeaderSettings('العميل'),
                  ClientSearchField(),
                  const SizedBox(height: 12),
                  const TextHeaderSettings('المبلغ'),
                  FormBuilderTextField(
                    name: 'amount',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false,
                    ),
                    decoration: const InputDecoration(
                      hintText: "0.0 ل.س",
                      prefixIcon: Icon(Icons.money_outlined),
                    ),
                    validator: CustomValidator.amountValidator,
                  ),

                  const SizedBox(height: 12),
                  const TextHeaderSettings('ملاحظة'),
                  FormBuilderTextField(
                    name: 'note',
                    maxLength: 100,
                    decoration: const InputDecoration(
                      hintText: "ملاحظة (اختياري)",
                      prefixIcon: Icon(Icons.note_alt_outlined),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text("إلغاء"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: BlocConsumer<AddDebtCubit, AddDebtState>(
                          listener: (context, state) {
                            if (state is AddDebtSuccess) {
                              Navigator.pop(context);
                              customshowSnackBar(
                                context,
                                massege: "تم حفظ الدين بنجاح",
                              );
                            }
                            if (state is AddDebtError) {
                              Navigator.pop(context);
                              showerrorDialog(
                                context: context,
                                title: "فشل إضاافة الدين",
                                description: state.errMessage,
                              );
                            }
                          },
                          builder: (context, state) {
                            final isLoading = state is AddDebtLoading;
                            return ElevatedButton(
                              onPressed:
                                  isLoading
                                      ? null
                                      : () {
                                        if (formKey.currentState
                                                ?.saveAndValidate() ??
                                            false) {
                                          final data =
                                              formKey.currentState!.value;
                                          final client =
                                              data['client']
                                                  as ClientSearchDropDownEntity?;
                                          final rawAmount =
                                              (data['amount'] as String).trim();
                                          final normalized = rawAmount
                                              .replaceAll(',', '.');
                                          final amount = double.tryParse(
                                            normalized,
                                          );
                                          final note = data["note"] as String?;
                                          context.read<AddDebtCubit>().addDebt(
                                            client!.id,
                                            note,
                                            amount!,
                                          );
                                        }
                                      },
                              child:
                                  isLoading
                                      ? const SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: LoadingIndicator(
                                          indicatorType: Indicator.ballPulse,
                                          colors: [Colors.white],
                                          strokeWidth: 2,
                                        ),
                                      )
                                      : const Text("حفظ"),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
