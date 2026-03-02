import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];
  TaskProvider() {
    _loadInitialTasks();
  }

  void _loadInitialTasks() {
    _tasks.addAll([
      Task(
        name: "Study Flutter",
        description: "Learn Provider state management",
      ),
      Task(name: "Practice Coding", description: "Solve 2 problems daily"),
      Task(
        name: "Leetcode",
        description: "Practice Leetcode",
        isCompleted: true,
      ),
    ]);
  }

  List<Task> get tasks => _tasks;

  // ADD TASK
  void addTask(String name, String description) {
    _tasks.add(Task(name: name, description: description));
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
  int get completedTasks => _tasks.where((task) => task.isCompleted).length;
}
