import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpFormProvider {
  String nickName = '';
  String email = '';
  String interest = '';

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  final nickNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Necesitas usar un nickname'),
    MinLengthValidator(3, errorText: 'Mínimo 3 caracteres')
  ]);

  bool validateForm() {
    return registerFormKey.currentState?.validate() ?? false;
  }
}
