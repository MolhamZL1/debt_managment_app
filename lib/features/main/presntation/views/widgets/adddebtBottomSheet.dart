import 'package:debt_managment_app/core/functions/custom_validator.dart';
import 'package:debt_managment_app/core/utils/currency_formatter.dart';
import 'package:debt_managment_app/core/utils/show_err_dialog.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/debt_client_repo.dart';
import 'package:debt_managment_app/generated/l10n.dart';
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
    isDismissible: false,
    enableDrag: false,
    builder: (ctx) {
      final bottomInset = MediaQuery.of(ctx).viewInsets.bottom;
      final l10n = S.of(ctx);
      return BlocProvider(
        create: (context) => AddDebtCubit(getIt.get<DebtClientRepo>()),
        child: BlocConsumer<AddDebtCubit, AddDebtState>(
          listener: (blocContext, state) {
            if (state is AddDebtSuccess) {
              Navigator.pop(ctx, true);
              customshowSnackBar(context, massege: l10n.debtSavedSuccessfully);
            }
            if (state is AddDebtError) {
              Navigator.pop(ctx);
              showerrorDialog(
                context: context,
                title: l10n.addDebtFailed,
                description: state.errMessage,
              );
            }
          },
          builder: (blocContext, state) {
            final isLoading = state is AddDebtLoading;

            return PopScope(
              canPop: !isLoading,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomInset),
                child: AbsorbPointer(
                  absorbing: isLoading,
                  child: FormBuilder(
                    key: formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            l10n.addNewDebt,
                            textAlign: TextAlign.start,
                            style: Theme.of(ctx).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 24),

                          TextHeaderSettings(l10n.client),
                          const ClientSearchField(),
                          const SizedBox(height: 12),
                          TextHeaderSettings(l10n.amount),
                          FormBuilderTextField(
                            name: 'amount',
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: false,
                            ),
                            decoration: InputDecoration(
                              hintText: "0.0 ${selectedCurrencySymbol(ctx)}",
                              prefixIcon: const Icon(Icons.money_outlined),
                            ),
                            validator: CustomValidator.amountValidator,
                          ),

                          const SizedBox(height: 12),
                          TextHeaderSettings(l10n.note),
                          FormBuilderTextField(
                            name: 'note',
                            maxLength: 100,
                            decoration: InputDecoration(
                              hintText: l10n.optionalNote,
                              prefixIcon: const Icon(Icons.note_alt_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed:
                                      isLoading
                                          ? null
                                          : () => Navigator.pop(ctx),
                                  child: Text(l10n.cancel),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
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
                                                  (data['amount'] as String)
                                                      .trim();
                                              final normalized = rawAmount
                                                  .replaceAll(',', '.');
                                              final amount = double.tryParse(
                                                normalized,
                                              );
                                              final note =
                                                  data["note"] as String?;
                                              blocContext
                                                  .read<AddDebtCubit>()
                                                  .addDebt(
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
                                              indicatorType:
                                                  Indicator.ballPulse,
                                              colors: [Colors.white],
                                              strokeWidth: 2,
                                            ),
                                          )
                                          : Text(l10n.save),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
