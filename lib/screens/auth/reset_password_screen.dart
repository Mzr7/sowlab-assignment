import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {

  final TextEditingController _passwordController =
      TextEditingController();
  final TextEditingController _confirmController =
      TextEditingController();

  bool _obscure1 = true;
  bool _obscure2 = true;

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

                  /// 🔙 Back Button
                  GestureDetector(
                    onTap: () =>
                        Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Enter your new password below.",
                    style:
                        TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 30),

                  /// NEW PASSWORD
                  TextField(
                    controller:
                        _passwordController,
                    obscureText:
                        _obscure1,
                    decoration:
                        InputDecoration(
                      hintText:
                          "New Password",
                      filled: true,
                      fillColor:
                          Colors.grey
                              .shade200,
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    15),
                        borderSide:
                            BorderSide.none,
                      ),
                      suffixIcon:
                          IconButton(
                        icon: Icon(
                          _obscure1
                              ? Icons
                                  .visibility_off
                              : Icons
                                  .visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscure1 =
                                !_obscure1;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// CONFIRM PASSWORD
                  TextField(
                    controller:
                        _confirmController,
                    obscureText:
                        _obscure2,
                    decoration:
                        InputDecoration(
                      hintText:
                          "Confirm Password",
                      filled: true,
                      fillColor:
                          Colors.grey
                              .shade200,
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    15),
                        borderSide:
                            BorderSide.none,
                      ),
                      suffixIcon:
                          IconButton(
                        icon: Icon(
                          _obscure2
                              ? Icons
                                  .visibility_off
                              : Icons
                                  .visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscure2 =
                                !_obscure2;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// SUBMIT BUTTON
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

                                  String pass =
                                      _passwordController
                                          .text
                                          .trim();
                                  String confirm =
                                      _confirmController
                                          .text
                                          .trim();

                                  if (pass.isEmpty ||
                                      confirm
                                          .isEmpty) {
                                    ScaffoldMessenger
                                            .of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "All fields required"),
                                      ),
                                    );
                                    return;
                                  }

                                  bool success =
                                      await authProvider
                                          .resetPassword(
                                              pass,
                                              confirm);

                                  if (success) {

                                    ScaffoldMessenger
                                            .of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Password changed successfully"),
                                      ),
                                    );

                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/login',
                                      (route) =>
                                          false,
                                    );

                                  } else {

                                    ScaffoldMessenger
                                            .of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          authProvider
                                                  .errorMessage ??
                                              "Reset failed",
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
                                  "Submit",
                                ),
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