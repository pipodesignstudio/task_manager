import 'package:flutter/material.dart';
import 'package:task_manager/widgets/loading_toast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Center(
      child: CustomLoadingToast(),
    );
  }
}


