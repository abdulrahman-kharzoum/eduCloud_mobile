import 'package:educloud_mobile/routing/app_router.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Error Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, AppRouter.homeScreen),
          child: const Text("Go to home page"),
        ),
      ),
    );
  }
}
