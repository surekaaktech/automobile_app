import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Routes/app_routes.dart';

import '../../Theme/app_colors.dart';

class CustomFooter extends StatelessWidget {
  final int currentIndex;

  const CustomFooter({
    super.key,
    this.currentIndex = -1,
  });

  void _handleTap(int index) {
    if (index == currentIndex) return; // Already on this tab

    switch (index) {
      case 0:
        // Home - pop to first route
        Get.until((route) => route.isFirst);
        break;
      case 1:
        // Emergency
        Get.toNamed(AppRoutes.emergency);
        break;
      case 2:
        // Laws
        Get.toNamed(AppRoutes.laws);
        break;
      case 3:
        // Profile
        Get.toNamed(AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            currentIndex: currentIndex >= 0 ? currentIndex : 0,
            onTap: _handleTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: currentIndex < 0 ? AppColors.primary : AppColors.secondary,
            selectedLabelStyle: TextStyle(
              fontWeight: currentIndex < 0 ? FontWeight.w600 : FontWeight.bold,
              fontSize: currentIndex < 0 ? 11 : 13,
              color: AppColors.primary,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              color: currentIndex < 0 ? AppColors.primary : AppColors.secondary,
            ),
            iconSize: 26,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: Icon(currentIndex < 0 ? Icons.home_outlined : Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.medical_services_outlined),
                activeIcon: Icon(currentIndex < 0 ? Icons.medical_services_outlined : Icons.medical_services),
                label: 'Emergency',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.balance_outlined),
                activeIcon: Icon(currentIndex < 0 ? Icons.balance_outlined : Icons.balance),
                label: 'Laws',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                activeIcon: Icon(currentIndex < 0 ? Icons.person_outline : Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
