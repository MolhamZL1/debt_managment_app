import 'package:debt_managment_app/core/functions/custom_validator.dart';
import 'package:debt_managment_app/core/utils/show_err_dialog.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/payment_client_repo.dart';
import 'package:debt_managment_app/core/cubits/add%20payment/add_payment_cubit.dart';
import 'package:debt_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/services/get_it_service.dart';
import '../../../../../core/utils/custom_snack_bar.dart';
import '../../../../settings/presentation/view/widgets/TextHeaderSettings.dart';
import '../../../domain/entities/ClientSearchDropDownEntity.dart';
import 'ClientSearchField.dart';

Future<dynamic> addpaymentBottomSheet(BuildContext context) {
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
        create: (context) => AddPaymentCubit(getIt.get<PaymentClientRepo>()),
        child: BlocConsumer<AddPaymentCubit, AddPaymentState>(
          listener: (blocContext, state) {
            if (state is AddPaymentSuccess) {
              Navigator.pop(ctx, true);
              customshowSnackBar(
                context,
                massege: l10n.paymentAddedSuccessfully,
              );
            }
            if (state is AddPaymentError) {
              Navigator.pop(ctx);
              showerrorDialog(
                context: context,
                title: l10n.addPaymentFailed,
                description: state.errMessage,
              );
            }
          },
          builder: (blocContext, state) {
            final isLoading = state is AddPaymentLoading;

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
                            l10n.addNewPayment,
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
                              hintText: "0.0 ${l10n.currencySyp}",
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
                                                  .read<AddPaymentCubit>()
                                                  .addPayment(
                                                    clientId: client!.id,
                                                    note: note,
                                                    amount: amount!,
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
                                          : Text(l10n.pay),
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
