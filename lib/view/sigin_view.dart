import 'package:flutter/material.dart';
import '../model/signin_model.dart';
import '../design/custom_button.dart';
import '../design/custom_textfield.dart';
import '../theme/text_styles.dart';
import 'dashboard_view.dart';
import 'signup_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final SignInModel model = SignInModel();
  String email = '';
  String password = '';
  String? error;

  void _login() {
    if (model.validateCredentials(email.trim(), password.trim())) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardView()));
    } else {
      setState(() {
        error = 'Invalid credentials';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // use theme background
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/devils.png', // your logo path
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 12),
                const Text('Denim & Devils Clothing', style: AppTextStyles.heading),
                const SizedBox(height: 8),
                const Text('Sign in to continue', style: AppTextStyles.subheading),
                const SizedBox(height: 40),

                CustomTextField(hintText: "Email", icon: Icons.email, onChanged: (v) => email = v),
                const SizedBox(height: 16),
                CustomTextField(hintText: "Password", icon: Icons.lock, onChanged: (v) => password = v, isPassword: true),
                const SizedBox(height: 8),

                if (error != null) ...[
                  Text(error!, style: const TextStyle(color: Colors.redAccent)),
                  const SizedBox(height: 12, width: 40),
                ],

                CustomButton(label: "SIGN IN", onPressed: _login),
                const SizedBox(height: 16),

                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpView())),
                  child: const Text("Don't have an account? Sign up", style: AppTextStyles.subheading),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
