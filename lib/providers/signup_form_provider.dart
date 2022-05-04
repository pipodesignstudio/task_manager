import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpFormProvider {
  String nickName = '';
  String email = '';
  String interest = '';
  String password = '';

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  final nickNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Necesitas usar un nickname'),
    MinLengthValidator(3, errorText: 'Mínimo 3 caracteres')
  ]);

  final emailValidator = MultiValidator([
    EmailValidator(errorText: 'Eso no parece un email'),
    RequiredValidator(errorText: 'Necesitamos un email'),
  ]);
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Te has olvidado de la contraseña'),
    MinLengthValidator(8, errorText: 'Mínimo 8 caracteres'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Falta un caracter especial')
  ]);

  bool validateForm() {
    return registerFormKey.currentState?.validate() ?? false;
  }
}
