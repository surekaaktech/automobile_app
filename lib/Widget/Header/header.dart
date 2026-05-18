import 'package:flutter/material.dart';
import '../../Routes/app_routes.dart';
import '../../Theme/app_colors.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary, // Premium Porsche-inspired green
      elevation: 0,
      automaticallyImplyLeading: false, // Removes the back arrow
      centerTitle: false,
      toolbarHeight: 70, // Increased toolbar height
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0), // Added some bottom padding to the title content
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.directions_car_outlined, color: AppColors.textLight, size: 28),
            const SizedBox(width: 8),
            Text(
              'AutoFind',
              style: TextStyle(
                color: AppColors.textLight,
                fontFamily: 'Outfit', // A modern premium-feeling font family matching the styling guidelines
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textLight, size: 28),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
        const SizedBox(width: 8),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20), // Added a subtle curve for better aesthetics
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80); // Increased preferred height
}
