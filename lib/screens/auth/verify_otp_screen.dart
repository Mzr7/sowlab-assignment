import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() =>
      _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  final List<FocusNode> _focusNodes =
      List.generate(4, (_) => FocusNode());

  String get enteredOtp =>
      _controllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {

    final authProvider =
        Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor:
          const Color(0xFFF6ECEA),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              /// Back Button
              GestureDetector(
                onTap: () =>
                    Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Verification",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Enter the 4-digit code sent to your phone",
                style:
                    TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 40),

              /// OTP BOXES
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children:
                    List.generate(4, (index) {
                  return SizedBox(
                    width: 60,
                    child: TextField(
                      controller:
                          _controllers[index],
                      focusNode:
                          _focusNodes[index],
                      keyboardType:
                          TextInputType.number,
                      textAlign:
                          TextAlign.center,
                      maxLength: 1,
                      decoration:
                          InputDecoration(
                        counterText: "",
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
                      ),
                      onChanged:
                          (value) {
                        if (value
                                .isNotEmpty &&
                            index < 3) {
                          _focusNodes[
                                  index +
                                      1]
                              .requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 40),

              /// VERIFY BUTTON
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

                              if (enteredOtp
                                      .length !=
                                  4) {
                                ScaffoldMessenger
                                        .of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Enter 4 digit OTP"),
                                  ),
                                );
                                return;
                              }

                              bool success =
                                  await authProvider
                                      .verifyOtp(
                                          enteredOtp);

                              if (success) {

                                ScaffoldMessenger
                                        .of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "OTP verified successfully"),
                                  ),
                                );

                                Navigator.pushNamed(
                                  context,
                                  '/reset-password',
                                );

                              } else {

                                ScaffoldMessenger
                                        .of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      authProvider
                                              .errorMessage ??
                                          "Invalid OTP",
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
                              "Verify",
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
    );
  }
}