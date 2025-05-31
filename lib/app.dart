import 'package:flutter/material.dart';
import 'view/splash_screen_view.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Denim & devils',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,  // <-- Apply your theme here
      home: SplashScreenView(),
    );
  }
}
