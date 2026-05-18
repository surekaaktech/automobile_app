import 'package:flutter/material.dart';
import '../../Routes/app_routes.dart';
import '../../Theme/app_colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  String? _errorMessage;

  void _handleReset() {
    final username = _usernameController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (username.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields';
      });
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        _errorMessage = 'Passwords do not match';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password updated successfully!'),
        backgroundColor: AppColors.success,
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: AppColors.textSecondary,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.normal),
            fillColor: AppColors.background,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌌 Deep Forest Ambient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryDark, Color(0xFF0F2513), AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 🟢 Ambient Glowing Blob
          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryLight.withOpacity(0.25),
              ),
            ),
          ),

          // 🟡 Ambient Glowing Blob
          Positioned(
            bottom: -60,
            right: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withOpacity(0.12),
              ),
            ),
          ),

          // 📄 Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 🚗 Premium Glowing Brand Icon
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.08),
                            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryLight.withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.directions_car_outlined,
                            size: 44,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 🏷️ Trendy Brand Typo
                      const Text(
                        'AutoFind',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontFamily: 'Outfit',
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'THE MODERN AUTOMOBILE COMPANION',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary.withOpacity(0.7),
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 36),

                      // 🪟 Frosted Glassmorphic Card
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 30,
                              offset: const Offset(0, 15),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Reset Password',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                                fontFamily: 'Outfit',
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Create a secure new password for your account',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 28),

                            if (_errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  _errorMessage!,
                                  style: const TextStyle(color: AppColors.accentRed, fontSize: 13, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ),

                            _buildTextField(
                              label: 'USERNAME / EMAIL',
                              hintText: 'Enter username or email',
                              icon: Icons.person_outline,
                              controller: _usernameController,
                            ),
                            _buildTextField(
                              label: 'NEW PASSWORD',
                              hintText: 'Enter secure password',
                              icon: Icons.lock_outline,
                              controller: _newPasswordController,
                              isPassword: true,
                            ),
                            _buildTextField(
                              label: 'CONFIRM NEW PASSWORD',
                              hintText: 'Confirm secure password',
                              icon: Icons.lock_outline,
                              controller: _confirmPasswordController,
                              isPassword: true,
                            ),
                            const SizedBox(height: 12),

                            // Dynamic Gradient Button
                            GestureDetector(
                              onTap: _handleReset,
                              child: Container(
                                height: 56,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [AppColors.primary, AppColors.primaryLight],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.3),
                                      blurRadius: 15,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Update Password',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),

                            // Login Redirect Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Remembered? ",
                                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                                  },
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
