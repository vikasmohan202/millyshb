import 'package:flutter/material.dart';
import 'package:millyshb/view/nav_screen.dart';

class StoreSplashScreen extends StatefulWidget {
  final bool isFood;

  const StoreSplashScreen({super.key, required this.isFood});

  @override
  _StoreSplashScreenState createState() => _StoreSplashScreenState();
}

class _StoreSplashScreenState extends State<StoreSplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 1.0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _startAnimation();
    _navigateToHome();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _opacity = 0.0;
      });
    });
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const NavScreen(),
        transitionsBuilder: (context, animation1, animation2, child) {
          return FadeTransition(
            opacity: animation1,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 1000),
          child: widget.isFood
              ? Image.asset(
                  'assets/images/food_splash.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                )
              : Image.asset(
                  'assets/images/cosmetics_splash.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
        ),
      ),
    );
  }
}
