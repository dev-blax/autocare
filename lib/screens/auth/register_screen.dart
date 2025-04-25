import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _vehicleMakeController = TextEditingController();
  final _vehicleModelController = TextEditingController();
  final _vehicleYearController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    _vehicleMakeController.dispose();
    _vehicleModelController.dispose();
    _vehicleYearController.dispose();
    super.dispose();
  }

  void _showSuccessDialog(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      setState(() => _isLoading = false);
      if (mounted) {
        _showSuccessDialog('Registration successful! Please login to continue.');
      }
    }
  }

  void _handleSocialSignup(String provider) {
    _showSuccessDialog('$provider signup successful! Please login to continue.');
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String placeholder,
    required IconData icon,
    bool isPassword = false,
    bool isConfirmPassword = false,
    TextInputType? keyboardType,
  }) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      obscureText: isPassword ? !_isPasswordVisible : (isConfirmPassword ? !_isConfirmPasswordVisible : false),
      keyboardType: keyboardType,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      prefix: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Icon(icon),
      ),
      suffix: (isPassword || isConfirmPassword)
          ? CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                (isPassword ? _isPasswordVisible : _isConfirmPasswordVisible)
                    ? CupertinoIcons.eye_slash
                    : CupertinoIcons.eye,
              ),
              onPressed: () {
                setState(() {
                  if (isPassword) {
                    _isPasswordVisible = !_isPasswordVisible;
                  } else {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  }
                });
              },
            )
          : null,
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.systemGrey4),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Register'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // welcome to autocare
                const SizedBox(height: 32),
                const Text(
                  'Welcome to AutoCare',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Create an account',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 32),
                _buildTextField(
                  controller: _fullNameController,
                  placeholder: 'Full Name (Optional)',
                  icon: CupertinoIcons.person,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _emailController,
                  placeholder: 'Email',
                  icon: CupertinoIcons.mail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _phoneController,
                  placeholder: 'Phone Number',
                  icon: CupertinoIcons.phone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _passwordController,
                  placeholder: 'Password',
                  icon: CupertinoIcons.lock,
                  isPassword: true,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _confirmPasswordController,
                  placeholder: 'Confirm Password',
                  icon: CupertinoIcons.lock,
                  isConfirmPassword: true,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Vehicle Details (Optional)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _vehicleMakeController,
                  placeholder: 'Make',
                  icon: CupertinoIcons.car,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _vehicleModelController,
                  placeholder: 'Model',
                  icon: CupertinoIcons.car_detailed,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _vehicleYearController,
                  placeholder: 'Year',
                  icon: CupertinoIcons.calendar,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                if (_isLoading)
                  const CupertinoActivityIndicator()
                else
                  CupertinoButton.filled(
                    onPressed: _handleRegister,
                    child: const Text('Register'),
                  ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('OR'),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                CupertinoButton(
                  color: CupertinoColors.systemGrey5,
                  onPressed: () => _handleSocialSignup('Google'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/DeviconGoogle.svg', height: 24),
                      const SizedBox(width: 8),
                      const Text('Sign up with Google'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                CupertinoButton(
                  color: CupertinoColors.black,
                  onPressed: () => _handleSocialSignup('Apple'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/IcSharpApple.svg',
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          CupertinoColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('Sign up with Apple'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    CupertinoButton(
                      child: const Text('Login'),
                      onPressed: () => context.go('/login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
