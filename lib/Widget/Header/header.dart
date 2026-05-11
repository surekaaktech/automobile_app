import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF955BFF), // Purple color matching the image
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 70, // Increased toolbar height
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0), // Added some bottom padding to the title content
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.directions_car_outlined, color: Colors.white, size: 28),
            const SizedBox(width: 8),
            const Text(
              'AutoFind',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 28),
            onPressed: () {},
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
