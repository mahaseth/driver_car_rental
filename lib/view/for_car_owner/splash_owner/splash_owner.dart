import 'package:flutter/material.dart';

class SplashScreenOwner extends StatefulWidget {
  const SplashScreenOwner({super.key});

  @override
  State<SplashScreenOwner> createState() => _SplashScreenOwnerState();
}

class _SplashScreenOwnerState extends State<SplashScreenOwner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: const []),
    );
  }
}
