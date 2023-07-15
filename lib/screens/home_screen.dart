import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text("Home")),
          Row(
            children: [
              Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.amberAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
