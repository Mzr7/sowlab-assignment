import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {

    final authProvider =
        Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor:
          const Color(0xFFF6ECEA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(
                    horizontal: 24),
            child: Container(
              padding:
                  const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  /// App Name
                  const Text(
                    "FarmerEats",
                    style:
                        TextStyle(fontSize: 14),
                  ),

                  const SizedBox(height: 20),

                  /// Welcome Text
                  const Text(
                    "Welcome back!",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Create Account
                  Row(
                    children: [
                      const Text(
                          "New here? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context,
                              '/signup');
                        },
                        child: const Text(
                          "Create account",
                          style: TextStyle(
                            color: Color(
                                0xFFE67E63),
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// EMAIL FIELD
                  TextField(
                    controller:
                        _emailController,
                    keyboardType:
                        TextInputType
                            .emailAddress,
                    decoration:
                        InputDecoration(
                      hintText:
                          "Email Address",
                      prefixIcon:
                          const Icon(Icons
                              .alternate_email),
                      filled: true,
                      fillColor:
                          Colors.grey
                              .shade200,
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(15),
                        borderSide:
                            BorderSide
                                .none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// PASSWORD FIELD
                  TextField(
                    controller:
                        _passwordController,
                    obscureText:
                        _obscurePassword,
                    decoration:
                        InputDecoration(
                      hintText:
                          "Password",
                      prefixIcon:
                          const Icon(Icons
                              .lock_outline),
                      filled: true,
                      fillColor:
                          Colors.grey
                              .shade200,
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(15),
                        borderSide:
                            BorderSide
                                .none,
                      ),
                      suffixIcon:
                          IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons
                                  .visibility_off
                              : Icons
                                  .visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword =
                                !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Forgot Password
                  Align(
                    alignment:
                        Alignment
                            .centerRight,
                    child:
                        GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context,
                            '/forgot-password');
                      },
                      child: const Text(
                        "Forgot?",
                        style: TextStyle(
                          color: Color(
                              0xFFE67E63),
                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// LOGIN BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child:
                        ElevatedButton(
                      style:
                          ElevatedButton
                              .styleFrom(
                        backgroundColor:
                            const Color(
                                0xFFE67E63),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      30),
                        ),
                      ),
                      onPressed:
                          authProvider
                                  .isLoading
                              ? null
                              : () async {

                                  bool success =
                                      await authProvider
                                          .login(
                                    email:
                                        _emailController
                                            .text
                                            .trim(),
                                    password:
                                        _passwordController
                                            .text
                                            .trim(),
                                  );

                                  if (success) {
                                    Navigator
                                        .pushReplacementNamed(
                                      context,
                                      '/home',
                                    );
                                  } else {
                                    ScaffoldMessenger
                                            .of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          authProvider
                                                  .errorMessage ??
                                              "Login failed",
                                        ),
                                      ),
                                    );
                                  }
                                },
                      child:
                          authProvider
                                  .isLoading
                              ? const CircularProgressIndicator(
                                  color:
                                      Colors
                                          .white,
                                )
                              : const Text(
                                  "Login",
                                  style:
                                      TextStyle(
                                          fontSize:
                                              16),
                                ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Center(
                    child:
                        Text("or login with"),
                  ),

                  const SizedBox(height: 20),

                  /// SOCIAL BUTTONS
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceEvenly,
                    children: [
                      _socialButton(
                          Icons.g_mobiledata),
                      _socialButton(
                          Icons.apple),
                      _socialButton(
                          Icons.facebook),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(
      IconData icon) {
    return Container(
      padding:
          const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.grey.shade300),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child:
          Icon(icon, size: 28),
    );
  }
}