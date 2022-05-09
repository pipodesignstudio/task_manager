import 'package:flutter/material.dart';
import 'package:task_manager/providers/auth_provider.dart';
import 'package:task_manager/providers/login_form_provider.dart';
import 'package:task_manager/shared/custom_colors.dart';
import 'package:task_manager/shared/custom_inputs.dart';
import 'package:task_manager/widgets/outlined_buttons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared/custom_buttons.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<LoginFormProvider>(context);
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
              Text('👋 ¡Hola de nuevo!',
                  style: Theme.of(context).textTheme.headline3),
              const SizedBox(
                height: 30,
              ),
              _LoginForm(
                formProvider: formProvider,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
    required this.formProvider,
  }) : super(key: key);

  final LoginFormProvider formProvider;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
      key: formProvider.loginFormKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: formProvider.email,
            onChanged: (value) => formProvider.email = value,
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
            obscureText: true,
            style: GoogleFonts.inter(
                color: CustomColors.body, fontWeight: FontWeight.w500),
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Ionicons.lock_closed_outline),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, 'resetpass');
                  },
                  icon: const Icon(Ionicons.help_buoy_outline),
                  label: const Text('¿Contraseña olvidada?')),
            ],
          ),
          const SizedBox(
            height: 150,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'signup');
            },
            child: const Text('No tienes cuenta? Regístrate gratis'),
            style: CustomButton.linkBtn,
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              if (!formProvider.validateForm()) {
                return;
              }
              authProvider.signIn(formProvider.email, formProvider.password);
            },
            child: const Text(
              'Inicio de sesión',
            ),
            style: CustomButton.mainBtn,
          ),
        ],
      ),
    );
  }
}
