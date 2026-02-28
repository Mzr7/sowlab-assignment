import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/placeholder_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/verify_otp_screen.dart';
import 'screens/auth/reset_password_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/signup_step2_screen.dart';
import 'screens/auth/signup_step3_screen.dart';
import 'screens/auth/signup_step4_screen.dart';
import 'screens/auth/signup_success_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          '/onboarding': (context) =>
              const OnboardingScreen(),
          '/home': (context) =>
              const PlaceholderScreen(title: "Home"),
          '/login': (context) =>
              const LoginScreen(),
          '/forgot-password': (context) =>
              const ForgotPasswordScreen(),
          '/verify-otp': (context) => OtpScreen(),
          '/reset-password': (context) => const ResetPasswordScreen(),
          '/signup': (context) => SignupScreen(),
          '/signup-step2': (context) => const SignupStep2Screen(),
          '/signup-step3': (context) =>
              const SignupStep3Screen(),
          '/signup-step4': (context) =>
              const SignupStep4Screen(), 
          '/signup-success': (context) =>
              const SignupSuccessScreen(),   
        },
      ),
    );
  }
}