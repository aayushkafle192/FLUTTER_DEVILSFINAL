// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; 
// import 'package:lottie/lottie.dart';
// import 'package:rolo/core/utils/page_transitions.dart';
// import 'package:rolo/features/auth/presentation/view/login_page_view.dart';
// import 'package:rolo/features/dashboard/presentation/view/dashboard_view.dart';
// import 'package:rolo/features/splash/presentation/view_model/splash_view_model.dart'; 

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SplashViewModel()..decideNavigation(),
//       child: BlocListener<SplashViewModel, SplashState>(
//         listener: (context, state) {
//           if (state == SplashState.navigateToHome) {
//             Navigator.of(context).pushReplacement(
//               PageTransitions.fadeIn(const DashboardView()), 
//             );
//           } else if (state == SplashState.navigateToLogin) {
//             Navigator.of(context).pushReplacement(
//               PageTransitions.fadeIn(const LoginScreen()),
//             );
//           }
//         },
//         child: const _SplashAnimationView(),
//       ),
//     );
//   }
// }

// class _SplashAnimationView extends StatefulWidget {
//   const _SplashAnimationView();

//   @override
//   State<_SplashAnimationView> createState() => __SplashAnimationViewState();
// }

// class __SplashAnimationViewState extends State<_SplashAnimationView> with TickerProviderStateMixin {
//   late AnimationController _controller;
//   bool _isAnimationLoaded = false;
  
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//   }
  
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Lottie.asset(
//           'assets/animations/rolo_splash_aniations.json',
//           width: 888,
//           height: 1920,
//           fit: BoxFit.contain,
//           controller: _controller,
//           onLoaded: (composition) {
//             setState(() {
//               _isAnimationLoaded = true;
//               _controller.duration = composition.duration;
//               _controller.forward();
//             });
//           },
//           frameBuilder: (context, child, composition) {
//             if (_isAnimationLoaded) {
//               return child;
//             } else {
//               return const Center(child: Text("Denim and", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }





























import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:lottie/lottie.dart';
import 'package:rolo/core/utils/page_transitions.dart';
import 'package:rolo/features/auth/presentation/view/login_page_view.dart';
import 'package:rolo/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:rolo/features/splash/presentation/view_model/splash_view_model.dart'; 

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashViewModel()..decideNavigation(),
      child: BlocListener<SplashViewModel, SplashState>(
        listener: (context, state) {
          if (state == SplashState.navigateToHome) {
            Navigator.of(context).pushReplacement(
              PageTransitions.fadeIn(const DashboardView()), 
            );
          } else if (state == SplashState.navigateToLogin) {
            Navigator.of(context).pushReplacement(
              PageTransitions.fadeIn(const LoginScreen()),
            );
          }
        },
        child: const _SplashAnimationView(),
      ),
    );
  }
}

class _SplashAnimationView extends StatefulWidget {
  const _SplashAnimationView();

  @override
  State<_SplashAnimationView> createState() => __SplashAnimationViewState();
}

class __SplashAnimationViewState extends State<_SplashAnimationView> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _isAnimationLoaded = false;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F0F0F), Color(0xFF1A1A1A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Company Logo (adjust the path if needed)
              Image.asset(
                'assets/images/devils.png',
                height: 120,
              ),
              const SizedBox(height: 20),
              const Text(
                'DENIM AND DEVILS',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              Lottie.asset(
                'assets/animations/business.json',
                width: 250,
                height: 250,
                fit: BoxFit.contain,
                controller: _controller,
                onLoaded: (composition) {
                  setState(() {
                    _isAnimationLoaded = true;
                    _controller.duration = composition.duration;
                    _controller.forward();
                  });
                },
                frameBuilder: (context, child, composition) {
                  if (_isAnimationLoaded) {
                    return child;
                  } else {
                    return Column(
                      children: const [
                        SizedBox(height: 40),
                        Text(
                          "Loading...",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20),
                        CircularProgressIndicator(color: Colors.white54),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
