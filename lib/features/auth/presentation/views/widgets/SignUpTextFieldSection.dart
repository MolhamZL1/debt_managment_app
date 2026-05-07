import 'package:debt_managment_app/core/utils/data.dart';
import 'package:debt_managment_app/features/auth/presentation/views/widgets/CustomPasswordTextField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/functions/custom_validator.dart';

class SignUpTextFieldSection extends StatelessWidget {
  const SignUpTextFieldSection({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormBuilderState> _formKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الاسم',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          FormBuilderTextField(
            name: "name",
            decoration: const InputDecoration(label: Text('الاسم')),
            validator: CustomValidator.nameValidator,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.name],
          ),

          const SizedBox(height: 16),
          Text(
            ' رقم الهاتف',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          FormBuilderTextField(
            name: "number",
            decoration: const InputDecoration(label: Text('رقم الهاتف')),
            keyboardType: TextInputType.phone,
            validator: CustomValidator.phoneValidator,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.telephoneNumber],
          ),

          const SizedBox(height: 16),
          Text(
            'البريد الالكتروني',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          FormBuilderTextField(
            name: "email",
            decoration: const InputDecoration(label: Text('البريد الالكتروني')),
            keyboardType: TextInputType.emailAddress,
            validator: CustomValidator.emailValidator,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
          ),

          const SizedBox(height: 16),
          Text(
            ' كلمة المرور',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          CustomPasswordTextField(
            name: 'password',
            label: 'كلمة المرور',
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.newPassword],
          ),

          const SizedBox(height: 16),
          Text(
            'تأكيد كلمة المرور',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          CustomPasswordTextField(
            name: 'password_confirmation',
            label: 'تأكيد كلمة المرور',
            isPasswordConfirm: true,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: FormBuilderCheckbox(
              name: 'accept_terms',
              title: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    const TextSpan(text: 'أوافق على '),
                    TextSpan(
                      text: 'الشروط والأحكام',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),

                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              launchUrl(Uri.parse(Data.termsAndConditionsUrl));
                            },
                    ),
                    TextSpan(
                      text: ' و ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: 'سياسة الخصوصية',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              launchUrl(Uri.parse(Data.privacyPolicyUrl));
                            },
                    ),
                  ],
                ),
              ),

              initialValue: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
              ),
              validator: FormBuilderValidators.equal(
                true,
                errorText: 'يجب الموافقة على الشروط والاحكام للمتابعة',
              ),
              // يلتزم بثيم الـ Checkbox من الـ MaterialApp تلقائيًا
            ),
          ),
        ],
      ),
    );
  }
}
