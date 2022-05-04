import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginFormProvider {
  String email = '';
  String password = '';

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final nickNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Necesitas usar un nickname'),
    MinLengthValidator(3, errorText: 'Mínimo 3 caracteres')
  ]);

  bool validateForm() {
    return loginFormKey.currentState?.validate() ?? false;
  }
}
