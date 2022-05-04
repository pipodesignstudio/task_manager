import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:task_manager/providers/signup_form_provider.dart';
import 'package:task_manager/services/user_creation_service.dart';
import 'package:task_manager/shared/custom_colors.dart';
import 'package:task_manager/shared/custom_inputs.dart';
import 'package:task_manager/widgets/outlined_buttons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared/custom_buttons.dart';

import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<SignUpFormProvider>(context);
    final createrUserProvider = Provider.of<UserCreationService>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: OutlinedIconButton(
          icon: Ionicons.arrow_back,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 35,
            ),
            Text('👋 Vamos a crear tu cuenta',
                style: Theme.of(context).textTheme.headline3),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              child: Form(
                  key: formProvider.registerFormKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: formProvider.nickNameValidator,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) =>
                                  formProvider.nickName = value,
                              style: GoogleFonts.inter(
                                  color: CustomColors.body,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecorations.authInputDecoration(
                                  labelText: 'Nombre de usuario',
                                  prefixIcon: Ionicons.at_outline),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          OutlinedButton(
                            onPressed: () async {
                              SmartDialog.showLoading();

                              await createrUserProvider
                                  .checkUserNickname(formProvider.nickName)
                                  .then((value) => {
                                        if (createrUserProvider.validNickname)
                                          {print('Nickname válido')}
                                        else
                                          {print('Nickname erroneo')}
                                      });
                              if (kDebugMode) {
                                print(formProvider.nickName);
                              }

                              SmartDialog.dismiss();
                            },
                            child: const Icon(
                                Ionicons.checkmark_done_circle_outline),
                            style: CustomButton.secondaryBtnSm,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: GoogleFonts.inter(
                            color: CustomColors.body,
                            fontWeight: FontWeight.w500),
                        decoration: InputDecorations.authInputDecoration(
                            labelText: 'Email',
                            prefixIcon: Ionicons.mail_outline),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        style: GoogleFonts.inter(
                            color: CustomColors.body,
                            fontWeight: FontWeight.w500),
                        decoration: InputDecorations.authInputDecoration(
                            labelText: 'Contraseña',
                            prefixIcon: Ionicons.lock_closed_outline),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        '¿Para qué planeas utilizar Tasker',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const _SelectInterest()
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class _SelectInterest extends StatefulWidget {
  const _SelectInterest({Key? key}) : super(key: key);

  @override
  State<_SelectInterest> createState() => __SelectInterestState();
}

class __SelectInterestState extends State<_SelectInterest> {
  @override
  Widget build(BuildContext context) {
    final List<String> interests = [
      'Marketing',
      'Programación',
      'Gestión',
      'Diseño',
      'Contabilidad'
    ];
    return SizedBox(
      height: 55,
      child: DropdownButtonFormField<String>(
        style: GoogleFonts.inter(
            color: CustomColors.body, fontWeight: FontWeight.w500),
        isExpanded: true,
        decoration: InputDecorations.authInputDecoration(),
        iconEnabledColor: CustomColors.primary,
        icon: const Icon(Ionicons.chevron_down_outline),
        iconSize: 16,
        hint: const Text('Área de interés'),
        value: interests.first,
        onChanged: (value) {
          setState(() {});
        },
        items: interests.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
      ),
    );
  }
}
