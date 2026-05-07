import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../core/functions/custom_validator.dart';
import 'CustomPasswordTextField.dart';

class SignInTextFieldSection extends StatelessWidget {
  const SignInTextFieldSection({
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
            'البريد الالكتروني أو الرقم',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          FormBuilderTextField(
            name: "email",
            keyboardType: TextInputType.emailAddress,
            validator: CustomValidator.emailOrPhoneNumberValidator,
            textInputAction: TextInputAction.next,
            autofillHints: const [
              AutofillHints.email,
              AutofillHints.telephoneNumber,
            ],
            decoration: const InputDecoration(
              labelText: "البريد الالكتروني أو الرقم",
            ),
          ),
          SizedBox(height: 16),
          Text(
            ' كلمة المرور',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          CustomPasswordTextField(
            name: 'password',
            label: 'كلمة المرور',
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.newPassword],
          ),
        ],
      ),
    );
  }
}
