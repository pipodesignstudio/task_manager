import 'package:flutter/material.dart';
import 'package:task_manager/shared/custom_colors.dart';

class CustomButton {
  static ButtonStyle mainBtn = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(CustomColors.primary),
    foregroundColor: MaterialStateProperty.all(CustomColors.secondary),
    minimumSize: MaterialStateProperty.all(const Size(220, 50)),
  );

  static ButtonStyle secondaryBtn = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(CustomColors.secondary),
    foregroundColor: MaterialStateProperty.all(CustomColors.primary),
    minimumSize: MaterialStateProperty.all(const Size(220, 50)),
  );
}
