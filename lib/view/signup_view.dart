import 'package:flutter/material.dart';
import 'package:sprint1_project/view/sigin_view.dart';
import '../design/custom_button.dart';
import '../design/custom_textfield.dart';
import '../theme/text_styles.dart';
// import 'signin_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String? error;

  void _register() {
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() => error = 'Please fill all fields');
    } else if (password != confirmPassword) {
      setState(() => error = 'Passwords do not match');
    } else {
      // Proceed to dashboard or handle registration logic
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignInView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(Icons.person_add, size: 60, color: Colors.white),
                const SizedBox(height: 12),
                const Text('Create Account', style: AppTextStyles.heading),
                const SizedBox(height: 8),
                const Text('Sign up to get started', style: AppTextStyles.subheading),
                const SizedBox(height: 40),

                CustomTextField(hintText: "Full Name", icon: Icons.person, onChanged: (v) => name = v),
                const SizedBox(height: 16),
                CustomTextField(hintText: "Email", icon: Icons.email, onChanged: (v) => email = v),
                const SizedBox(height: 16),
                CustomTextField(hintText: "Password", icon: Icons.lock, onChanged: (v) => password = v, isPassword: true),
                const SizedBox(height: 16),
                CustomTextField(hintText: "Confirm Password", icon: Icons.lock, onChanged: (v) => confirmPassword = v, isPassword: true),
                const SizedBox(height: 8),

                if (error != null) ...[
                  Text(error!, style: const TextStyle(color: Colors.redAccent)),
                  const SizedBox(height: 12),
                ],

                CustomButton(label: "SIGN UP", onPressed: _register),
                const SizedBox(height: 16),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Already have an account? Sign in", style: AppTextStyles.subheading),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
