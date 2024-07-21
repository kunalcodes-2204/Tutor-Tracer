import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tutor_tracer/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.nextScreen});

  final TeacherAvailabilityScreen nextScreen;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget.nextScreen),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 253, 255, 253),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.3, // Adjust the top position
              child: Lottie.asset(
                'assets/Animation.json', // Path to your loader animation
                width: 225,
                height: 225,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.6, // Adjust the top position
              child: const Text(
                'Welcome to TutorTracer',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.black, // Text color
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              child: Lottie.asset(
                'assets/loader_animation.json', // Path to your loader animation
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
