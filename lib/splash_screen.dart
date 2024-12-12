import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Start the timer to navigate to the main screen
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const FoodDeliveryScreen(),
      ));
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 75, 75), // Set background to white
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display logo image
            Image.asset(
              'assets/Logo.jpg', // Ensure logo.jpeg exists in the assets folder
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'Canteen TB',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255), // Change text color to black
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
