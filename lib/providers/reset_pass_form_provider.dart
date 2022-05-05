import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ResetPassFormProvider {
  String email = '';
  final GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();

  final emailValidator = MultiValidator([
    EmailValidator(errorText: 'Eso no parece un email'), 
    RequiredValidator(errorText: 'No puedes dejar esto vacío')
  ]);

  bool isValidForm() {
    if(resetFormKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

}