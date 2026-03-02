import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  // ADD TASK
  void addTask(String name, String description) {
    _tasks.add(Task(
      name: name,
      description: description,
    ));
    notifyListeners();
  }

  // TOGGLE TASK
  void toggleTask(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();
  }

  // DELETE TASK
  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  // TOTAL COUNT
  int get totalTasks => _tasks.length;

  // COMPLETED COUNT
  int get completedTasks =>
      _tasks.where((task) => task.isCompleted).length;
}