import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      if (authProvider.authStatus == AuthStatus.authenticated) {
        Navigator.pushReplacementNamed(context, 'home');
      }
    });

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          LogoContainer(),
          SizedBox(
            height: 20,
          ),
          CupertinoActivityIndicator(),
          SizedBox(
            height: 150,
          )
        ],
      ),
    ));
  }
}

class LogoContainer extends StatelessWidget {
  const LogoContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Image.asset(
          'assets/img/tasker_logo.png',
          width: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
