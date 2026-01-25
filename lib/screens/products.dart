import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products_provider.dart';
import '../provider/cart_provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildCategoryChip(BuildContext context, String category) {
      final provider = context.watch<ProductsProvider>();
      final isSelected = provider.selectedCategory == category;

      return ChoiceChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (_) {
          provider.setCategory(category);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              children: [
                buildCategoryChip(context, 'All'),
                buildCategoryChip(context, 'Men'),
                buildCategoryChip(context, 'Women'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<ProductsProvider>().setSortType(SortType.name);
                  },
                  child: const Text('Sort by Name'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProductsProvider>().setSortType(
                      SortType.priceLowToHigh,
                    );
                  },
                  child: const Text('Price: Low to High'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProductsProvider>().setSortType(
                      SortType.priceHighToLow,
                    );
                  },
                  child: const Text('Price: High to Low'),
                ),
              ],
            ),
          ),

          Expanded(
            child: Consumer<ProductsProvider>(
              builder: (context, provider, child) {
                final products = provider.products;

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (ctx, i) {
                    final product = products[i];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(product.name),
                            const SizedBox(height: 8),
                            Text(product.description),
                            const SizedBox(height: 8),
                            Text(product.category),
                            const SizedBox(height: 8),
                            Text(product.price.toStringAsFixed(2)),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  final cartProvider =
                                      context.read<CartProvider>();
                                  cartProvider.addToCart(
                                    productId: product.id,
                                    name: product.name,
                                    price: product.price,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${product.name} added to cart',
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Add To Cart'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
