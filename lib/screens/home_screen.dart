import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/providers/task_provider.dart';
import 'package:taskmanager/providers/theme_provider.dart';
import 'package:taskmanager/screens/add_task_screen.dart';
import 'package:taskmanager/widget/app_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: const Color(0xff129EF0),
        title: const Text(
          "Task Manager",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AppBackground(child: AddTaskScreen()),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Task"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            /// TASK STATS
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    context,
                    "Total",
                    provider.totalTasks.toString(),
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    context,
                    "Pending",
                    (provider.totalTasks - provider.completedTasks).toString(),
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    context,
                    "Completed",
                    provider.completedTasks.toString(),
                    Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// TASK LIST
            Expanded(
              child: ListView.builder(
                itemCount: provider.tasks.length,
                itemBuilder: (context, index) {
                  final task = provider.tasks[index];

                  return Card(
                    color: task.isCompleted
                        ? Colors.green.shade600
                        : Colors.orange.shade600,
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => provider.toggleTask(index),

                      child: Padding(
                        padding: const EdgeInsets.all(16),

                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    task.description,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Checkbox(
                              value: task.isCompleted,
                              onChanged: (_) => provider.toggleTask(index),
                              activeColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                            ),

                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => provider.deleteTask(index),
                            ),
                          ],
                        ),
                      ),
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

  /// STAT CARD
  Widget _statCard(
    BuildContext context,
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
