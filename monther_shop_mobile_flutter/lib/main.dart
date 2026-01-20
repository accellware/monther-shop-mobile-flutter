import 'package:flutter/material.dart';

void main() {
  runApp(const MotherShopApp());
}

class MotherShopApp extends StatelessWidget {
  const MotherShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monther Shop',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: const HomePage(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mother Shop'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Ready for development'),
      ),
    );
  }
}
