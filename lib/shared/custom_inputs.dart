import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_colors.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    String? hintText,
    String? labelText,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.workSans(color: CustomColors.body, fontSize: 14),
        fillColor: Colors.white,
        border: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: CustomColors.gray300)),
        filled: true,
        focusColor: CustomColors.primary,
        errorMaxLines: 1,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: CustomColors.gray300, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
        errorStyle: GoogleFonts.workSans(color: CustomColors.primary),
        labelText: labelText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        labelStyle: const TextStyle(color: CustomColors.body),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: CustomColors.body)
            : null,
        suffixIcon: suffixIcon,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: CustomColors.gray300,
        )),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: CustomColors.primary, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ));
  }
}
