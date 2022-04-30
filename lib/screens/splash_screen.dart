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
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(16, 24, 40, .08),
                  blurRadius: 16,
                  spreadRadius: -4,
                  offset: Offset(0, 12)),
              BoxShadow(
                  color: Color.fromRGBO(16, 24, 40, .08),
                  blurRadius: 16,
                  spreadRadius: -4,
                  offset: Offset(0, 4)),
            ]),
        child: Center(
          child: Image.asset(
            'assets/img/task_logo.png',
            fit: BoxFit.contain,
          ),
        ));
  }
}
