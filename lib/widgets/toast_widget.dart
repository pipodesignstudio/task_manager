import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NotificationToast extends StatelessWidget {

  NotificationToast({ Key? key, required this.msg }) : super(key: key);
  String msg;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(msg, style: const TextStyle(color: Colors.white)),
      );
  }
}