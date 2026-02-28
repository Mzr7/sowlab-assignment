import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SignupStep4Screen extends StatefulWidget {
  const SignupStep4Screen({super.key});

  @override
  State<SignupStep4Screen> createState() =>
      _SignupStep4ScreenState();
}

class _SignupStep4ScreenState
    extends State<SignupStep4Screen> {

  String selectedDay = "mon";

  final Map<String, String> dayLabels = {
    "mon": "M",
    "tue": "T",
    "wed": "W",
    "thu": "Th",
    "fri": "F",
    "sat": "S",
    "sun": "Su",
  };

  final List<String> timeSlots = [
    "8:00am - 10:00am",
    "10:00am - 1:00pm",
    "1:00pm - 4:00pm",
    "4:00pm - 7:00pm",
    "7:00pm - 10:00pm",
  ];

  @override
  Widget build(BuildContext context) {

    final authProvider =
        Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F6F4),
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
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 20),

              const Text(
                "Signup 4 of 4",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 8),

              const Text(
                "Business Hours",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Choose the hours your farm is open for pickups. This will allow customers to order deliveries.",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              /// DAY SELECTOR
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: dayLabels.entries.map((entry) {

                  final isSelected =
                      selectedDay == entry.key;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDay = entry.key;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFD2694C)
                            : Colors.grey.shade200,
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      child: Text(
                        entry.value,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 30),

              /// TIME SLOT GRID
              Expanded(
                child: GridView.builder(
                  itemCount: timeSlots.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 3,
                  ),
                  itemBuilder: (context, index) {

                    final slot =
                        timeSlots[index];

                    final isSelected =
                        authProvider.businessHours[selectedDay]
                                ?.contains(slot) ??
                            false;

                    return GestureDetector(
                      onTap: () {
                        authProvider.toggleBusinessHour(
                            selectedDay, slot);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFE6B35A)
                              : Colors.grey.shade200,
                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                        child: Text(
                          slot,
                          style:
                              const TextStyle(fontSize: 13),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              /// ✅ SUBMIT BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFD2694C),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: authProvider.isLoading
                      ? null
                      : () async {

                          bool success =
                              await authProvider
                                  .registerUser();

                          if (success) {
                            Navigator.pushNamed(
                              context,
                              '/signup-success',
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Registration failed"),
                              ),
                            );
                          }
                        },
                  child: authProvider.isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}