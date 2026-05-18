import 'package:flutter/material.dart';
import '../../Routes/app_routes.dart';
import '../../Theme/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _accountType = 'Customer';
  bool _agreedToTerms = false;
  String? _errorMessage;

  void _handleRegister() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = 'Passwords do not match';
      });
      return;
    }

    if (!_agreedToTerms) {
      setState(() {
        _errorMessage = 'Please agree to the terms to continue';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
    });

    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
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
      resizeToAvoidBottomInset: false,
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
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
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
                              'Create Account',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                                fontFamily: 'Outfit',
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Join the next-gen automobile network',
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
                              label: 'USERNAME',
                              hintText: 'Choose a username',
                              icon: Icons.alternate_email,
                              controller: _usernameController,
                            ),
                            _buildTextField(
                              label: 'PASSWORD',
                              hintText: 'Create strong password',
                              icon: Icons.lock_outline,
                              controller: _passwordController,
                              isPassword: true,
                            ),
                            _buildTextField(
                              label: 'CONFIRM PASSWORD',
                              hintText: 'Confirm your password',
                              icon: Icons.lock_outline,
                              controller: _confirmPasswordController,
                              isPassword: true,
                            ),

                            // Account Type Label
                            const Text(
                              'ACCOUNT TYPE',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textSecondary,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Trendy Pill-Shaped Role Selector
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => _accountType = 'Customer'),
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: _accountType == 'Customer' ? AppColors.primary : AppColors.background,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: _accountType == 'Customer' ? AppColors.primary : AppColors.border,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Customer',
                                          style: TextStyle(
                                            color: _accountType == 'Customer' ? Colors.white : AppColors.textPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => _accountType = 'Service Provider'),
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: _accountType == 'Service Provider' ? AppColors.primary : AppColors.background,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: _accountType == 'Service Provider' ? AppColors.primary : AppColors.border,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Provider',
                                          style: TextStyle(
                                            color: _accountType == 'Service Provider' ? Colors.white : AppColors.textPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Terms & Conditions Checkbox
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Checkbox(
                                    value: _agreedToTerms,
                                    activeColor: AppColors.primary,
                                    checkColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                    onChanged: (value) {
                                      setState(() {
                                        _agreedToTerms = value ?? false;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Text(
                                    'I agree to the User Agreement and Privacy Policy.',
                                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 28),

                            // Dynamic Gradient Button
                            GestureDetector(
                              onTap: _handleRegister,
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
                                    'Sign Up',
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
                                  "Already have an account? ",
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
          ),
        ],
      ),
    );
  }
}
