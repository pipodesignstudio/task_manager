import 'package:flutter/material.dart';
import 'package:task_manager/shared/custom_colors.dart';

class OutlinedIconButton extends StatelessWidget {

  final IconData icon;
  final Function onPressed;

  const OutlinedIconButton({ Key? key, required this.icon, required this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.gray300),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Center(
            child: Icon(icon, color: CustomColors.primary,),
          ),
        ),
      ),
    );
  }
}