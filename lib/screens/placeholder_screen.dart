import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen(
      {super.key, required this.title});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor:
            const Color(0xFFE67E63),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {

            final authProvider =
                Provider.of<AuthProvider>(
                    context,
                    listen: false);

            await authProvider.logout();

            Navigator.pushReplacementNamed(
                context,
                '/login');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                const Color(0xFFE67E63),
          ),
          child: const Text("Logout"),
        ),
      ),
    );
  }
}