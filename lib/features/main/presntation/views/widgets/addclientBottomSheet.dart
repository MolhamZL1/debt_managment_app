import 'package:debt_managment_app/core/functions/custom_validator.dart';
import 'package:debt_managment_app/core/utils/custom_snack_bar.dart';
import 'package:debt_managment_app/core/utils/show_err_dialog.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/clientes_repo.dart';
import 'package:debt_managment_app/features/main/presntation/cubits/add%20client/add_client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/services/get_it_service.dart';
import '../../../../settings/presentation/view/widgets/TextHeaderSettings.dart';

Future<dynamic> addclientBottomSheet(BuildContext context) {
  final formKey = GlobalKey<FormBuilderState>();

  return showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (ctx) {
      final bottomInset = MediaQuery.of(ctx).viewInsets.bottom;
      return BlocProvider(
        create: (context) => AddClientCubit(getIt.get<ClientesRepo>()),
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
                    "إضافة عميل جديد",
                    textAlign: TextAlign.start,
                    style: Theme.of(ctx).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 24),

                  const TextHeaderSettings('اسم العميل'),
                  //تاكد ان اسم العميل غير موجود
                  FormBuilderTextField(
                    name: 'name',
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "اسم العميل",
                      prefixIcon: Icon(Icons.person_outlined),
                    ),
                    validator: CustomValidator.nameValidator,
                  ),
                  const SizedBox(height: 12),
                  const TextHeaderSettings('رقم الموبايل'),
                  FormBuilderTextField(
                    name: 'phone',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false,
                    ),
                    decoration: const InputDecoration(
                      hintText: "( اختياري )",
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    validator: CustomValidator.amountValidator,
                  ),

                  const SizedBox(height: 12),
                  const TextHeaderSettings('العنوان'),
                  FormBuilderTextField(
                    name: 'address',
                    maxLength: 100,
                    decoration: const InputDecoration(
                      hintText: "( اختياري )",
                      prefixIcon: Icon(Icons.location_on_outlined),
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
                        child: BlocConsumer<AddClientCubit, AddClientState>(
                          listener: (context, state) {
                            if (state is AddClientSuccess) {
                              Navigator.pop(context);
                              customshowSnackBar(
                                context,
                                massege: "تمت إضافة العميل بنجاح",
                              );
                            }
                            if (state is AddClientFailure) {
                              Navigator.pop(context);
                              showerrorDialog(
                                context: context,
                                title: "فشلت إضافة العميل",
                                description: state.errorMessage,
                              );
                            }
                          },
                          builder: (context, state) {
                            final isLoading = state is AddClientLoading;
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
                                          context
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
