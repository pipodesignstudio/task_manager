import 'package:flutter/material.dart';
import 'package:task_manager/shared/custom_colors.dart';

class CustomButton {
  static ButtonStyle mainBtn = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(CustomColors.primary),
    foregroundColor: MaterialStateProperty.all(Colors.white),
    minimumSize: MaterialStateProperty.all(const Size(220, 50)),
  );

  static ButtonStyle secondaryBtn = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.white),
    side: MaterialStateProperty.all(const BorderSide(color: CustomColors.gray300, width: 2)),
    foregroundColor: MaterialStateProperty.all(CustomColors.primary),
    minimumSize: MaterialStateProperty.all(const Size(220, 50)),
  );
}
