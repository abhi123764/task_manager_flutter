import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widget/app_background.dart';
import 'providers/task_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: const ColorScheme.light(primary: Color(0xff129EF0)),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: const ColorScheme.dark(primary: Color(0xff00F2FE)),
      ),

      
      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,

      home: const AppBackground(child: HomeScreen()),
    );
  }
}
