class Task {
  bool taskComplete;
  String taskName;
  String taskTime;
  String taskPriority;
  String? taskDescription;

  Task(
      {required this.taskComplete,
      required this.taskName,
      this.taskDescription,
      required this.taskPriority,
      required this.taskTime});
}
