import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task_manager/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    Future.delayed(const Duration(milliseconds: 1000), () async {
      if (authProvider.authStatus == AuthStatus.notAuthenticated) {
        Navigator.pushReplacementNamed(context, 'launch');
      }
      Navigator.pushReplacementNamed(context, 'home');
    });

    return Scaffold(
      body: Center(child: Lottie.asset('assets/lottie/loading.json')),
    );
  }
}
