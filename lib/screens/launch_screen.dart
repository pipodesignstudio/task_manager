import 'package:flutter/material.dart';
import 'package:task_manager/shared/custom_buttons.dart';
import 'package:task_manager/shared/custom_textstyle.dart';
import 'package:animate_do/animate_do.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInLeft(child: Image.asset('assets/img/welcome.png')),
              Text(
                'Hora de empezar a gestionar tus tareas de forma eficiente',
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'signup');
                },
                child: const Text('Regístrate'),
                style: CustomButton.mainBtn,
              ),
              const SizedBox(
                height: 15,
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Inicia sesión'),
                style: CustomButton.secondaryBtn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
