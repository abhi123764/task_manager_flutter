import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/providers/theme_provider.dart';
import '../providers/task_provider.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDark;

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
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Task"),
        foregroundColor: isDark
            ? const Color(0xff00F2FE)
            : const Color.fromARGB(255, 31, 29, 29),
        backgroundColor: isDark
            ? const Color.fromARGB(255, 31, 29, 29)
            : const Color(0xff00F2FE),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color.fromARGB(255, 0, 0, 0), const Color(0xff414345)]
                : [const Color(0xff129EF0), const Color(0xff00F2FE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [
              /// TASK STATS
              Row(
                children: [
                  /// TOTAL
                  Expanded(
                    child: _statCard(
                      "Total",
                      provider.totalTasks.toString(),
                      Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// PENDING
                  Expanded(
                    child: _statCard(
                      "Pending",
                      (provider.totalTasks - provider.completedTasks)
                          .toString(),
                      Colors.orange.shade500,
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// COMPLETED
                  Expanded(
                    child: _statCard(
                      "Completed",
                      provider.completedTasks.toString(),
                      const Color.fromARGB(255, 81, 230, 86),
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
                          ? const Color.fromARGB(255, 81, 230, 86)
                          : Colors.orange.shade500,

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
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    Text(
                                      task.description,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),

                              Checkbox(
                                value: task.isCompleted,
                                onChanged: (_) => provider.toggleTask(index),
                                activeColor: Colors.lightBlue,
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
      ),
    );
  }

  /// STAT CARD WIDGET
  Widget _statCard(String title, String value, Color color) {
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
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
