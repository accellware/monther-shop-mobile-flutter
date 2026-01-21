import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:monther_shop_mobile_flutter/screens/products.dart';
import 'provider/products_provider.dart';

void main() {
  runApp(const MotherShopApp());
}

class MotherShopApp extends StatelessWidget {
  const MotherShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ],
      child: MaterialApp(
        title: 'Shop',
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(),
        home: const HomePage(),
      ),
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
      appBar: AppBar(title: const Text('Shop'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(),
                  ),
                );
              },
              child: const Text('View Products'),
            ),
          ],
        ),
      ),
    );
  }
}
