import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:ionicons/ionicons.dart';
import 'package:task_manager/providers/auth_provider.dart';
import 'package:task_manager/providers/reset_pass_form_provider.dart';
import 'package:task_manager/shared/custom_buttons.dart';
import 'package:task_manager/shared/custom_colors.dart';
import 'package:task_manager/shared/custom_inputs.dart';
import 'package:task_manager/widgets/outlined_buttons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:task_manager/widgets/toast_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final formProvder = Provider.of<ResetPassFormProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: OutlinedIconButton(
          icon: Ionicons.arrow_back,
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: SingleChildScrollView(child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 35), child: Column(
          children: [
            const SizedBox(
                height: 35,
              ),
              Text('🤘 ¡La ayuda está en camino!',
                  style: Theme.of(context).textTheme.headline3),
              const SizedBox(
                height: 15,
              ),
              Text('Introduce el email con el que creaste tu cuenta y te enviaremos por correo las instrucciones para que puedas reestablecer tu contraseña', style: Theme.of(context).textTheme.bodyText1,), 
              const SizedBox(height: 20,),
              Form(
                key: formProvder.resetFormKey,
                child: Column(
                children: [
                  TextFormField(
                    validator: formProvder.emailValidator,
                    onChanged: (value) => formProvder.email = value,
            style: GoogleFonts.inter(
                color: CustomColors.body, fontWeight: FontWeight.w500),
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Email', prefixIcon: Ionicons.mail_outline),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: () async{
           if ( !formProvder.isValidForm() ) {
             return;
           }
           await authProvider.resetPassword(formProvder.email).then((value) => {
             SmartDialog.show(widget: NotificationToast(msg: 'Email enviado')),
             Navigator.pushReplacementNamed(context, 'login')
           });
          }, child: const Text('Resetar contraseña'), style: CustomButton.mainBtn,)
                ],
              ))
          ],
        ),
      )),
    );
  }
}