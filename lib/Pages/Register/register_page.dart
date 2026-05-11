import 'package:flutter/material.dart';
import '../../Routes/app_routes.dart';

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

    // Navigate to Home Screen after successful registration
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
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: bold,
            color: Color(0xFF0C1427),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black38),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF222845)),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  static const FontWeight bold = FontWeight.bold;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFF222845),
                    child: Icon(
                      Icons.directions_car_outlined,
                      size: 40,
                      color: Color(0xFF4A5578),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    'AutoFind',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0C1427),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  const Text(
                    'Create your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 32),

                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  _buildTextField(
                    label: 'Username',
                    hintText: 'Enter username',
                    controller: _usernameController,
                  ),
                  _buildTextField(
                    label: 'Password',
                    hintText: 'Enter password',
                    controller: _passwordController,
                    isPassword: true,
                  ),
                  _buildTextField(
                    label: 'Confirm Password',
                    hintText: 'Confirm password',
                    controller: _confirmPasswordController,
                    isPassword: true,
                  ),

                  // Account Type
                  const Text(
                    'Account Type',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: bold,
                      color: Color(0xFF0C1427),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Customer',
                        groupValue: _accountType,
                        activeColor: const Color(0xFF222845),
                        onChanged: (value) {
                          setState(() {
                            _accountType = value!;
                          });
                        },
                      ),
                      const Text('Customer'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Service Provider',
                        groupValue: _accountType,
                        activeColor: const Color(0xFF222845),
                        onChanged: (value) {
                          setState(() {
                            _accountType = value!;
                          });
                        },
                      ),
                      const Text('Service Provider'),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Terms & Conditions
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _agreedToTerms,
                          activeColor: const Color(0xFF222845),
                          onChanged: (value) {
                            setState(() {
                              _agreedToTerms = value ?? false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'I agree to the User Agreement and Privacy Policy.\nBy registering, I consent to the collection and use of my information as described.',
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Register Button
                  ElevatedButton(
                    onPressed: _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF222845),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate back to login screen
                          Navigator.pushReplacementNamed(context, AppRoutes.login);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xFF0C1427),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
