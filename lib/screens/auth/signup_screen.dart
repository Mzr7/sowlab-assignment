import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends State<SignupScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController
      _fullNameController =
      TextEditingController();
  final TextEditingController
      _emailController =
      TextEditingController();
  final TextEditingController
      _phoneController =
      TextEditingController();
  final TextEditingController
      _passwordController =
      TextEditingController();
  final TextEditingController
      _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authProvider =
        Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F6F4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                /// Back Button
                GestureDetector(
                  onTap: () =>
                      Navigator.pop(context),
                  child: const Icon(
                    Icons
                        .arrow_back_ios_new,
                    size: 20,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "FarmerEats",
                  style: TextStyle(
                      fontSize: 16),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Signup 1 of 4",
                  style: TextStyle(
                      color:
                          Colors.grey),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Welcome!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                _buildTextField(
                  controller:
                      _fullNameController,
                  hint: "Full Name",
                ),

                const SizedBox(height: 16),

                _buildTextField(
                  controller:
                      _emailController,
                  hint:
                      "Email Address",
                  keyboardType:
                      TextInputType
                          .emailAddress,
                ),

                const SizedBox(height: 16),

                _buildTextField(
                  controller:
                      _phoneController,
                  hint:
                      "Phone Number",
                  keyboardType:
                      TextInputType.phone,
                ),

                const SizedBox(height: 16),

                _buildTextField(
                  controller:
                      _passwordController,
                  hint: "Password",
                  isPassword: true,
                ),

                const SizedBox(height: 16),

                _buildTextField(
                  controller:
                      _confirmPasswordController,
                  hint:
                      "Re-enter Password",
                  isPassword: true,
                ),

                const SizedBox(height: 30),

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
                              0xFFD2694C),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    30),
                      ),
                    ),
                    onPressed: () {

                      if (_formKey
                          .currentState!
                          .validate()) {

                        if (_passwordController
                                .text !=
                            _confirmPasswordController
                                .text) {
                          ScaffoldMessenger
                                  .of(
                                      context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Passwords do not match"),
                            ),
                          );
                          return;
                        }

                        /// Save to Provider
                        authProvider
                            .setFullName(
                          _fullNameController
                              .text
                              .trim(),
                        );

                        authProvider
                            .setEmail(
                          _emailController
                              .text
                              .trim(),
                        );

                        authProvider
                            .setPhoneNumber(
                          _phoneController
                              .text
                              .trim(),
                        );

                        authProvider
                            .setPassword(
                          _passwordController
                              .text
                              .trim(),
                        );

                        Navigator
                            .pushNamed(
                          context,
                          '/signup-step2',
                        );
                      }
                    },
                    child:
                        const Text(
                      "Continue",
                      style:
                          TextStyle(
                              fontSize:
                                  16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child:
                      GestureDetector(
                    onTap: () {
                      Navigator
                          .pop(context);
                    },
                    child:
                        const Text(
                      "Login",
                      style: TextStyle(
                        decoration:
                            TextDecoration
                                .underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController
        controller,
    required String hint,
    TextInputType keyboardType =
        TextInputType.text,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType:
          keyboardType,
      obscureText:
          isPassword,
      validator: (value) {
        if (value == null ||
            value.isEmpty) {
          return "Required";
        }
        return null;
      },
      decoration:
          InputDecoration(
        hintText: hint,
        filled: true,
        fillColor:
            Colors.grey
                .shade200,
        contentPadding:
            const EdgeInsets
                .symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius
                  .circular(
                      15),
          borderSide:
              BorderSide
                  .none,
        ),
        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius
                  .circular(
                      15),
          borderSide:
              BorderSide
                  .none,
        ),
        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius
                  .circular(
                      15),
          borderSide:
              BorderSide
                  .none,
        ),
      ),
    );
  }
}