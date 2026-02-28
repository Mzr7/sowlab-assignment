import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {

  final TextEditingController _phoneController =
      TextEditingController();

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
                    "FarmerEats",
                    style:
                        TextStyle(fontSize: 14),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Enter your registered mobile number to receive an OTP.",
                    style:
                        TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 30),

                  /// PHONE FIELD
                  TextField(
                    controller:
                        _phoneController,
                    keyboardType:
                        TextInputType.phone,
                    decoration:
                        InputDecoration(
                      hintText:
                          "Mobile Number",
                      prefixIcon:
                          const Icon(Icons.phone),
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

                  const SizedBox(height: 30),

                  /// SEND CODE BUTTON
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

                                  String phone =
                                      _phoneController
                                          .text
                                          .trim();

                                  if (phone.isEmpty) {
                                    ScaffoldMessenger
                                            .of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Please enter mobile number"),
                                      ),
                                    );
                                    return;
                                  }

                                  bool success =
                                      await authProvider
                                          .forgotPassword(
                                              phone);

                                  if (success) {

                                    ScaffoldMessenger
                                            .of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "OTP sent to your mobile"),
                                      ),
                                    );

                                    Navigator
                                        .pushNamed(
                                      context,
                                      '/verify-otp',
                                    );

                                  } else {

                                    ScaffoldMessenger
                                            .of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          authProvider
                                                  .errorMessage ??
                                              "Failed to send OTP",
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
                                  "Send Code",
                                  style:
                                      TextStyle(
                                          fontSize:
                                              16),
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