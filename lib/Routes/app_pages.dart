import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

// Auth
import '../Pages/Login/login_page.dart';
import '../Pages/Register/register_page.dart';
import '../Pages/Forgot/forgot_page.dart';

// Main
import '../Pages/Home/Home_Screen.dart';
import '../Pages/Menu/Menu_Screen.dart';

// Feature Screens
import '../Pages/Emergency/Emergency_Screen.dart';
import '../Pages/Laws/Laws_Screen.dart';
import '../Pages/Profile/profile_screen.dart';
import '../Pages/Favorite/favorite_screen.dart';

// Category & Company
import '../Pages/Subcategory/subcategory_screen.dart';
import '../Pages/Company/company_listing_screen.dart';
import '../Pages/Company/business_details_screen.dart';
import '../Pages/Company/company_compare_screen.dart';
import '../Pages/Company/write_review_screen.dart';

// Services
import '../Pages/Loan/loan_screen.dart';
import '../Pages/GovtForms/govt_forms_screen.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.login;

  static final routes = [
    // Auth
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: AppRoutes.forgot,
      page: () => const ForgotPasswordPage(),
    ),

    // Main
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.menu,
      page: () => const MenuScreen(),
    ),

    // Feature Screens
    GetPage(
      name: AppRoutes.emergency,
      page: () => const EmergencyScreen(),
    ),
    GetPage(
      name: AppRoutes.laws,
      page: () => const LawsScreen(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.favorite,
      page: () => const FavoriteScreen(),
    ),

    // Category & Company
    GetPage(
      name: AppRoutes.subcategory,
      page: () {
        final categoryName = Get.arguments as String? ?? "Category";
        return SubcategoryScreen(categoryName: categoryName);
      },
    ),
    GetPage(
      name: AppRoutes.companyListing,
      page: () {
        final args = Get.arguments as Map<String, dynamic>? ?? {};
        return CompanyListingScreen(
          categoryName: args['categoryName'] ?? 'Category',
          subcategoryName: args['subcategoryName'] ?? 'Listing',
        );
      },
    ),
    GetPage(
      name: AppRoutes.businessDetails,
      page: () {
        final company = Get.arguments as Map<String, dynamic>? ?? {};
        return BusinessDetailsScreen(company: company);
      },
    ),
    GetPage(
      name: AppRoutes.companyCompare,
      page: () {
        final companies = Get.arguments as List<Map<String, dynamic>>? ?? [];
        return CompanyCompareScreen(companies: companies);
      },
    ),
    GetPage(
      name: AppRoutes.writeReview,
      page: () {
        final company = Get.arguments as Map<String, dynamic>? ?? {};
        return WriteReviewScreen(company: company);
      },
    ),

    // Services
    GetPage(
      name: AppRoutes.loan,
      page: () => const LoanScreen(),
    ),
    GetPage(
      name: AppRoutes.govtForms,
      page: () => const GovtFormsScreen(),
    ),
  ];
}

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Placeholder for $title')),
    );
  }
}
