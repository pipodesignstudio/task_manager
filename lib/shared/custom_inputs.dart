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
        border: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: CustomColors.gray300),
            borderRadius: BorderRadius.circular(12)),
        filled: true,
        focusColor: CustomColors.primary,
        errorMaxLines: 1,
        errorBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: CustomColors.error300, width: 2.0),
          borderRadius: BorderRadius.circular(2.0),
        ),
        errorStyle: GoogleFonts.workSans(color: CustomColors.error500),
        labelText: labelText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        labelStyle: const TextStyle(color: CustomColors.body),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: CustomColors.body)
            : null,
        suffixIcon: suffixIcon,
        enabledBorder:  OutlineInputBorder(
            borderSide: const BorderSide(
          color: CustomColors.gray300,
        ),
        borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: CustomColors.primary, width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ));
  }
}
