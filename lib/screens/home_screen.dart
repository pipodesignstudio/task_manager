import 'package:flutter/material.dart';
import 'package:task_manager/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/shared/custom_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('cerrar sesión'),
          style: CustomButton.mainBtn,
          onPressed: () {
            authProvider.logOut();
            Navigator.pushReplacementNamed(context, 'splash');
          },
        ),
      ),
    );
  }
}
