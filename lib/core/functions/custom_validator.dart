import 'package:form_builder_validators/form_builder_validators.dart';

class CustomValidator {
  static String? emailOrPhoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    final phoneRegex = RegExp(r'^\+?[0-9]{9,15}$');

    if (!emailRegex.hasMatch(value) && !phoneRegex.hasMatch(value)) {
      return 'الرجاء إدخال بريد إلكتروني صالح أو رقم هاتف صالح';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.email(),
    ])(value);
  }

  static String? passwordValidator(String? value) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.minLength(8),
    ])(value);
  }

  static String? confirmPasswordValidator(
    String? password,
    String? confirmPassword,
  ) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.match(
        RegExp('^${RegExp.escape(password ?? '')}\$'),
        errorText: 'كلمتا المرور غير متطابقتين',
      ),
    ])(confirmPassword);
  }

  static String? nameValidator(String? value) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.minLength(3),
    ])(value);
  }

  static String? addressValidator(String? value) {
    return FormBuilderValidators.required()(value);
  }

  static String? phoneValidator(String? value) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.numeric(),
      FormBuilderValidators.minLength(9),
    ])(value);
  }

  static String? amountValidator(String? value) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.numeric(),
      FormBuilderValidators.positiveNumber(),
    ])(value);
  }
}
