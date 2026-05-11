import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF955BFF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.directions_car, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'AutoFind',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF955BFF).withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.close, color: Color(0xFF955BFF), size: 24),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _buildMenuCard(Icons.attach_money, "Loan")),
                  const SizedBox(width: 16),
                  Expanded(child: _buildMenuCard(Icons.description_outlined, "Govt\nForms")),
                  const SizedBox(width: 16),
                  Expanded(child: _buildMenuCard(Icons.menu_book_outlined, "Blog")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF955BFF),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
