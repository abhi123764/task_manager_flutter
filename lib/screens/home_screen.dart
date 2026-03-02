import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  void showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Add New Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Enter task name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Enter description",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  context.read<TaskProvider>().addTask(
                    nameController.text,
                    descController.text,
                  );

                  nameController.clear();
                  descController.clear();
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    double progress = provider.totalTasks == 0
        ? 0
        : provider.completedTasks / provider.totalTasks;

    return Scaffold(
      appBar: AppBar(title: const Text("Task Manager"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "Task Progress",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(value: progress),
                    const SizedBox(height: 10),
                    Text(
                      "${provider.completedTasks} of ${provider.totalTasks} completed",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: provider.tasks.length,
                itemBuilder: (context, index) {
                  final task = provider.tasks[index];

                  return ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (_) => provider.toggleTask(index),
                    ),
                    title: Text(task.name),
                    subtitle: Text(task.description),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => provider.deleteTask(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
