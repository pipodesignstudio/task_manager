import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:task_manager/shared/custom_colors.dart';
import 'package:task_manager/shared/custom_inputs.dart';
import 'package:task_manager/widgets/outlined_buttons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared/custom_buttons.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: OutlinedIconButton(icon: Ionicons.arrow_back, onPressed: () {
          Navigator.pop(context);
        },),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 35,),
            Text('👋 Vamos a crear tu cuenta', style: Theme.of(context).textTheme.headline3),
            const SizedBox(height: 30,),
            SingleChildScrollView(
              child: Form(child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: GoogleFonts.inter(
                            color: CustomColors.body,
                            fontWeight: FontWeight.w500
                          ),
                          decoration: InputDecorations.authInputDecoration(
                            labelText: 'Nombre de usuario'
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      OutlinedButton(
                onPressed: () async{
                  SmartDialog.showLoading();
                  await Future.delayed(const Duration(seconds: 2));
                  SmartDialog.dismiss();
                },
                child: const Text('Verificar'),
                style: CustomButton.secondaryBtnSm,
              ),
                    ],
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
