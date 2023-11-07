import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // final CustomUser? currentUser; // You should pass the user as a parameter

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Home Screen'), // Access the email property from the currentUser object
      ),
    );
  }
}
