import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../Pages/Home/Home_Screen.dart';
import '../Pages/Login/login_page.dart';
import '../Pages/Register/register_page.dart';
import '../Pages/Forgot/forgot_page.dart';
import '../Pages/Menu/Menu_Screen.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes => {
    AppRoutes.home: (context) => const HomeScreen(),
    AppRoutes.login: (context) => const LoginPage(),
    AppRoutes.register: (context) => const RegisterPage(),
    AppRoutes.forgot: (context) => const ForgotPasswordPage(),
    AppRoutes.menu: (context) => const MenuScreen(),
    // TODO: Uncomment and add other screens as they are created
    // AppRoutes.emergency: (context) => const EmergencyScreen(),
    // AppRoutes.laws: (context) => const LawsScreen(),
    // AppRoutes.profile: (context) => const ProfileScreen(),
  };
}
