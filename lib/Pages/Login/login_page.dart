import 'package:flutter/material.dart';
import '../../Routes/app_routes.dart';
import '../../Theme/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _emailError;
  String? _passwordError;

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    bool hasError = false;

    setState(() {
      // Email validation
      if (email.isEmpty) {
        _emailError = 'Email is required';
        hasError = true;
      } else if (!_isValidEmail(email)) {
        _emailError = 'Enter a valid email (e.g. user@example.com)';
        hasError = true;
      } else {
        _emailError = null;
      }

      // Password validation
      if (password.isEmpty) {
        _passwordError = 'Password is required';
        hasError = true;
      } else if (password.length < 6) {
        _passwordError = 'Password must be at least 6 characters';
        hasError = true;
      } else {
        _passwordError = null;
      }
    });

    if (!hasError) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

          // 🟢 Ambient Glowing Blob Top-Left
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

          // 🟡 Ambient Glowing Blob Bottom-Right
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
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                                fontFamily: 'Outfit',
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Sign in to access premium services',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 28),

                            // Error text
                            if (_emailError != null || _passwordError != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  _emailError ?? _passwordError ?? '',
                                  style: const TextStyle(color: AppColors.accentRed, fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ),

                            // Email label
                            const Text(
                              'EMAIL',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textSecondary,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Email Input Box
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primary, size: 20),
                                hintText: 'Enter your email',
                                hintStyle: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.normal),
                                fillColor: AppColors.background,
                                filled: true,
                                errorText: _emailError,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: _emailError != null
                                      ? const BorderSide(color: AppColors.accentRed, width: 1.5)
                                      : BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(color: AppColors.primary, width: 2),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Password label
                            const Text(
                              'PASSWORD',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textSecondary,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Password Input Box
                            TextField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary, size: 20),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                    color: AppColors.textSecondary,
                                    size: 20,
                                  ),
                                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                ),
                                hintText: 'Min. 6 characters',
                                hintStyle: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.normal),
                                fillColor: AppColors.background,
                                filled: true,
                                errorText: _passwordError,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: _passwordError != null
                                      ? const BorderSide(color: AppColors.accentRed, width: 1.5)
                                      : BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(color: AppColors.primary, width: 2),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Forgot link
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.forgot);
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: AppColors.primaryLight,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),

                            // Dynamic Gradient Button
                            GestureDetector(
                              onTap: _handleLogin,
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
                                    'Sign In',
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

                            // Register Option Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "New here? ",
                                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, AppRoutes.register);
                                  },
                                  child: const Text(
                                    "Create Account",
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
