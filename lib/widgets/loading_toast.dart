import 'package:flutter/material.dart';

import '../shared/custom_colors.dart';

class CustomLoadingToast extends StatelessWidget {
  const CustomLoadingToast({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: CustomColors.primary,
        borderRadius: BorderRadius.circular(30)
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const[
             CircularProgressIndicator(color: CustomColors.gray50,),
             SizedBox(height: 15,),
            Text('Estamos en ello... 💪')
          ],
        ),
      ),
    );
  }
}