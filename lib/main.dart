import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Routes/app_pages.dart';
import 'Routes/app_routes.dart';

import 'Theme/app_colors.dart';

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
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          background: AppColors.background,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          bodyLarge: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
