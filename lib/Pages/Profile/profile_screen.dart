import 'package:flutter/material.dart';
import '../../Theme/app_colors.dart';
import '../../Widget/Footer/footer.dart';
import '../Favorite/favorite_screen.dart';
import '../Login/login_page.dart';
import '../Maintenance/maintenance_reminder_screen.dart';
import '../ServiceHistory/service_history_screen.dart';
import '../VehicleDocuments/vehicle_documents_screen.dart';
import '../InsuranceManagement/insurance_management_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3; // Profile is the 4th item (index 3)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: const Icon(Icons.arrow_back, color: AppColors.textLight, size: 24),
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.textLight,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            fontFamily: 'Outfit',
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      bottomNavigationBar: CustomFooter(
        currentIndex: _currentIndex,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            // 🏷️ Grand, Increased Size User Info Card
            Container(
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.white, Color(0xFFFAFBFB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.border, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Enlarge Avatar from 80 to 100
                  // 🏎️ Supercar Tachometer Speedometer Cockpit Gauge
                  Container(
                    width: 116,
                    height: 116,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 12),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Speedometer Outer Gauge Arc
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: SweepGradient(
                                colors: [
                                  AppColors.primary,
                                  AppColors.primaryLight,
                                  AppColors.accent,
                                  Colors.redAccent,
                                  AppColors.primary,
                                ],
                                stops: [0.0, 0.4, 0.75, 0.9, 1.0],
                              ),
                            ),
                          ),
                        ),
                        // Cockpit Inner Bezel
                        Container(
                          width: 104,
                          height: 104,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0C190E), // Ultra-deep dark dashboard green
                            shape: BoxShape.circle,
                          ),
                        ),
                        // Dashboard User Initial Text
                        const Text(
                          'S',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Outfit',
                          ),
                        ),
                        // Instrument Needle Pointer (pointing to peak speed!)
                        Positioned(
                          right: 20,
                          top: 30,
                          child: Transform.rotate(
                            angle: 0.6,
                            child: Container(
                              width: 24,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'User',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textPrimary,
                            fontFamily: 'Outfit',
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'sri',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        
                        // Golden Role Tag Capsule
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.accent.withOpacity(0.25)),
                          ),
                          child: const Text(
                            'Customer',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // 🛠️ Profile Options - Card Size Increased
            _buildProfileOption(
              icon: Icons.favorite_border,
              title: 'Favorites',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoriteScreen()),
                );
              },
            ),
            _buildProfileOption(
              icon: Icons.history,
              title: 'Service History',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ServiceHistoryScreen()),
                );
              },
            ),
            _buildProfileOption(
              icon: Icons.notifications_none,
              title: 'Maintenance Reminders',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MaintenanceReminderScreen()),
                );
              },
            ),
            _buildProfileOption(
              icon: Icons.description_outlined,
              title: 'Vehicle Documentation',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VehicleDocumentsScreen()),
                );
              },
            ),
            _buildProfileOption(
              icon: Icons.security_outlined,
              title: 'Insurance Management',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InsuranceManagementScreen()),
                );
              },
            ),

            const SizedBox(height: 36),

            // 🚪 Premium Logout Button
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentRed.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout, color: AppColors.textLight, size: 20),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLight,
                      letterSpacing: 0.5,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentRed,
                    foregroundColor: AppColors.textLight,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16), // Increased spacing
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Increased rounding
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Increased Card Size/Padding
        leading: Container(
          padding: const EdgeInsets.all(12), // Increased padding
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary.withOpacity(0.12)),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800, // Extra weight for trendy look
            color: AppColors.textPrimary,
            fontFamily: 'Outfit',
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.secondary.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.chevron_right_rounded, color: AppColors.primary, size: 18),
        ),
      ),
    );
  }
}
