import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:task_manager/providers/auth_provider.dart';
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
            Navigator.pushReplacementNamed(context, 'launch');
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 35,
              ),
              Text('👋 Vamos a crear tu cuenta',
                  style: Theme.of(context).textTheme.headline3),
              const SizedBox(
                height: 30,
              ),
              SignUpForm(
                  formProvider: formProvider,
                  createrUserProvider: createrUserProvider),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
    required this.formProvider,
    required this.createrUserProvider,
  }) : super(key: key);

  final SignUpFormProvider formProvider;
  final UserCreationService createrUserProvider;

  @override
  Widget build(BuildContext context) {
    final nickNameController = TextEditingController();
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Form(
      key: formProvider.registerFormKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  validator: formProvider.nickNameValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) => formProvider.nickName = value,
                  style: GoogleFonts.inter(
                      color: CustomColors.body, fontWeight: FontWeight.w500),
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
                  if (formProvider.nickName.isEmpty ||
                      formProvider.nickName.length < 3) {
                    return;
                  }
                  SmartDialog.showLoading();

                  await createrUserProvider
                      .checkUserNickname(formProvider.nickName)
                      .then((value) => {
                            if (createrUserProvider.validNickname)
                              {SmartDialog.showToast('${formProvider.nickName} está disponible')}
                            else
                              nickNameController.clear()
                          });
                  if (kDebugMode) {
                    print(formProvider.nickName);
                  }

                  SmartDialog.dismiss();
                },
                child: const Icon(Ionicons.checkmark_done_circle_outline),
                style: CustomButton.secondaryBtnSm,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: formProvider.email,
            onChanged: (value) => formProvider.email = value,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: formProvider.emailValidator,
            style: GoogleFonts.inter(
                color: CustomColors.body, fontWeight: FontWeight.w500),
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Email', prefixIcon: Ionicons.mail_outline),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: formProvider.password,
            onChanged: (value) => formProvider.password = value,
            validator: formProvider.passwordValidator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: true,
            style: GoogleFonts.inter(
                color: CustomColors.body, fontWeight: FontWeight.w500),
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Ionicons.lock_closed_outline),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                '¿En qué te puede ayudar Tasker?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          _SelectInterest(
            formProvider: formProvider,
          ),
          const SizedBox(
            height: 50,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'login');
            },
            child: const Text('¿Ya tienes cuenta? Inicia sesión'),
            style: CustomButton.linkBtn,
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formProvider.validateForm()) {
                return;
              }
              SmartDialog.showLoading();
              await createrUserProvider
                  .checkUserNickname(formProvider.nickName)
                  .then((value) => {
                        if (createrUserProvider.validNickname)
                          {
                            authProvider.signUp(formProvider.email, formProvider.password, formProvider.interest, formProvider.nickName)
                          }
                        else
                          nickNameController.clear()
                      });
              SmartDialog.dismiss();
            },
            child: const Text(
              'Crear mi cuenta',
            ),
            style: formProvider.validateForm() ? CustomButton.mainBtn : CustomButton.disabledBtn,
          ),
        ],
      ),
    );
  }
}

class _SelectInterest extends StatefulWidget {
  final SignUpFormProvider formProvider;
  const _SelectInterest({Key? key, required this.formProvider})
      : super(key: key);

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
          widget.formProvider.interest = value!;
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
