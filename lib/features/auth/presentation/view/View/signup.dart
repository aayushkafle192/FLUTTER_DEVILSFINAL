import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softconnect/features/auth/presentation/view_model/signup_viewmodel/signup_event.dart';
import 'package:softconnect/features/auth/presentation/view_model/signup_viewmodel/signup_state.dart';
import 'package:softconnect/features/auth/presentation/view_model/signup_viewmodel/signup_viewmodel.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: BlocBuilder<SignupViewModel, SignupState>(
        builder: (context, state) {
          // Handle success state and navigate back
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Signup successful!"),
                  backgroundColor: Colors.green,
                ),
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pop(context); // Go back to LoginScreen
              });
            }
          });

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Join Denim & Devils Clothing",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Username
                      TextFormField(
                        controller: usernameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Full Name", Icons.person),
                        validator: (val) => val == null || val.isEmpty ? 'Enter name' : null,
                      ),
                      const SizedBox(height: 10),

                      // Email
                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Email Address", Icons.email),
                        validator: (val) => val == null || val.isEmpty ? 'Enter email' : null,
                      ),
                      const SizedBox(height: 10),

                      // Password
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Password", Icons.lock),
                        validator: (val) => val == null || val.length < 6 ? 'Password too short' : null,
                      ),
                      const SizedBox(height: 10),

                      // Confirm Password
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Confirm Password", Icons.lock_outline),
                        validator: (val) => val != passwordController.text ? 'Passwords do not match' : null,
                      ),
                      const SizedBox(height: 20),

                      // Signup Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<SignupViewModel>().add(
                                          SignupButtonPressed(
                                            email: emailController.text.trim(),
                                            username: usernameController.text.trim(),
                                            studentId: 0, // placeholder
                                            password: passwordController.text,
                                            role: "", // placeholder
                                            context: context,
                                          ),
                                        );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: state.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('SIGN UP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Already have account
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[850],
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
