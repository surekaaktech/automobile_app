import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Routes/app_pages.dart';
import 'Routes/app_routes.dart';

void main() {
  runApp(const AutomobileApp());
}

class AutomobileApp extends StatelessWidget {
  const AutomobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AutoApp - Premium Car Services',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF2D62ED),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2D62ED),
          primary: const Color(0xFF2D62ED),
          secondary: const Color(0xFF1A1A1A),
          background: const Color(0xFFF8F9FA),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF4A4A4A)),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF4A4A4A)),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
