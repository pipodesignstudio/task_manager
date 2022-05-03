import 'package:flutter/material.dart';
import 'package:task_manager/widgets/outlined_buttons.dart';
import 'package:ionicons/ionicons.dart';


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
      body: Column(
        children: const [
          //TODO:
        ],
      ),
    );
  }
}
