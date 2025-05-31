import 'package:flutter/material.dart';
import 'package:sprint1_project/model/splash_model.dart';
import 'package:sprint1_project/view/sigin_view.dart';

class SplashScreenView extends StatelessWidget {
  final SplashModel _viewmodel = SplashModel();

  SplashScreenView({super.key});

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 2));
    await _viewmodel.initApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const SignInView();
        } else {
          return const Scaffold(body: SplashContent());
        }
      },
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFb993d6), Color(0xFF8ca6db)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox(height: 24),
            const Text(
              'Denim & Devils',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}