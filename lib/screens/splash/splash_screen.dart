import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();

    _navigate();
  }

  Future<void> _navigate() async {

    final authProvider =
        Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    await Future.delayed(
        const Duration(seconds: 2));

    bool isLoggedIn =
        await authProvider
            .checkLoginStatus();

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(
          context, '/home');
    } else {
      Navigator.pushReplacementNamed(
          context, '/onboarding');
    }
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
            colors: [
              Color(0xFFE67E63),
              Color(0xFFD2694C),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisSize:
                    MainAxisSize.min,
                children: [

                  /// Logo
                  Container(
                    padding:
                        const EdgeInsets.all(
                            20),
                    decoration:
                        BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius
                              .circular(
                                  30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(
                                  0.2),
                          blurRadius: 20,
                          offset:
                              const Offset(
                                  0, 10),
                        )
                      ],
                    ),
                    child: const Icon(
                      Icons
                          .agriculture,
                      size: 60,
                      color:
                          Color(0xFFE67E63),
                    ),
                  ),

                  const SizedBox(
                      height: 30),

                  /// App Name
                  const Text(
                    "FarmerEats",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Colors.white,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(
                      height: 10),

                  /// Tagline
                  const Text(
                    "Fresh From Farm To Table",
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          Colors.white70,
                    ),
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