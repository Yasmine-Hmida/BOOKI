import 'package:flutter/material.dart';

class BiographyCategoryScreen extends StatelessWidget {
  const BiographyCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fiction'),
        backgroundColor: const Color(0xFF99582a),
      ),
      body: const Center(
        child: Text('Fiction Books Here'),
      ),
    );
  }
}
