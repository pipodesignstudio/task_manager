import 'package:task_manager/models/task_model.dart';

class UserModel {
  String uid;
  String email;
  String? name;
  String interest;
  List<Task>? tasks;

  UserModel(
      {required this.uid,
      required this.email,
      this.name,
      required this.interest,
      this.tasks});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'interestin': interest,
      'name': name ?? '',
      'tasks': tasks ?? []
    };
  }
}
