import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/providers/task_provider.dart';
import 'package:taskmanager/providers/theme_provider.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDark;

    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        title: const Text(
          "Add Task",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff129EF0),
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

          child: Center(
            child: Card(
              color: Theme.of(context).cardColor,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Create New Task",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: nameController,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),

                      decoration: InputDecoration(
                        labelText: "Task Name",
                        labelStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        prefixIcon: const Icon(Icons.task),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    TextField(
                      controller: descController,
                      maxLines: 3,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),

                      decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        prefixIcon: const Icon(Icons.description),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (nameController.text.isNotEmpty) {
                            context.read<TaskProvider>().addTask(
                              nameController.text,
                              descController.text,
                            );

                            Navigator.pop(context);
                          }
                        },

                        icon: const Icon(Icons.save),

                        label: const Text("Save Task"),

                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: isDark
                              ? const Color.fromARGB(255, 31, 29, 29)
                              : const Color(0xff23C2F3),

                          padding: const EdgeInsets.symmetric(vertical: 15),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
