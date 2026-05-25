import 'package:debt_managment_app/core/functions/custom_validator.dart';
import 'package:debt_managment_app/core/utils/custom_snack_bar.dart';
import 'package:debt_managment_app/core/utils/show_err_dialog.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/clientes_repo.dart';
import 'package:debt_managment_app/features/main/presntation/cubits/add%20client/add_client_cubit.dart';
import 'package:debt_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/services/get_it_service.dart';
import '../../../../settings/presentation/view/widgets/TextHeaderSettings.dart';

Future<bool?> addclientBottomSheet(BuildContext parentContext) {
  final formKey = GlobalKey<FormBuilderState>();

  return showModalBottomSheet<bool>(
    context: parentContext,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    isDismissible: false,
    enableDrag: false,
    builder: (sheetContext) {
      final bottomInset = MediaQuery.of(sheetContext).viewInsets.bottom;
      final l10n = S.of(sheetContext);
      return BlocProvider(
        create: (_) => AddClientCubit(getIt.get<ClientesRepo>()),
        child: BlocConsumer<AddClientCubit, AddClientState>(
          listener: (blocContext, state) {
            if (state is AddClientSuccess) {
              Navigator.pop(sheetContext, true);

              customshowSnackBar(
                parentContext,
                massege: l10n.clientAddedSuccessfully,
              );
            }

            if (state is AddClientFailure) {
              Navigator.pop(sheetContext);

              showerrorDialog(
                context: parentContext,
                title: l10n.addClientFailed,
                description: state.errorMessage,
              );
            }
          },
          builder: (blocContext, state) {
            final isLoading = state is AddClientLoading;

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
                            l10n.addNewClient,
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(sheetContext).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 24),

                          TextHeaderSettings(l10n.clientName),
                          FormBuilderTextField(
                            name: 'name',
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: l10n.clientName,
                              prefixIcon: const Icon(Icons.person_outlined),
                            ),
                            validator: CustomValidator.nameValidator,
                          ),

                          const SizedBox(height: 12),
                          TextHeaderSettings(l10n.phoneNumber),
                          FormBuilderTextField(
                            name: 'phone',
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: false,
                            ),
                            decoration: InputDecoration(
                              hintText: l10n.optional,
                              prefixIcon: const Icon(Icons.phone_outlined),
                            ),
                            validator: (v) {
                              return v == null
                                  ? null
                                  : CustomValidator.phoneValidator(v);
                            },
                          ),

                          const SizedBox(height: 12),
                          TextHeaderSettings(l10n.address),
                          FormBuilderTextField(
                            name: 'address',
                            maxLength: 100,
                            decoration: InputDecoration(
                              hintText: l10n.optional,
                              prefixIcon: const Icon(
                                Icons.location_on_outlined,
                              ),
                            ),
                            validator: (v) {
                              return v == null
                                  ? null
                                  : CustomValidator.addressValidator(v);
                            },
                          ),

                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed:
                                      isLoading
                                          ? null
                                          : () => Navigator.pop(sheetContext),
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
                                              blocContext
                                                  .read<AddClientCubit>()
                                                  .addClient(
                                                    name: data['name'],
                                                    address: data['address'],
                                                    phone: data['phone'],
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
