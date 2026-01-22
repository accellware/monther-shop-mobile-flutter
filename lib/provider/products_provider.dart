import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../model/product_model.dart';

enum SortType { name, priceLowToHigh, priceHighToLow }

class ProductsProvider extends ChangeNotifier {
  List<Product> _allProducts = [];

  String _selectedCategory = 'All';
  String get selectedCategory => _selectedCategory;
  SortType _sortType = SortType.name;

  ProductsProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('products').get();

      _allProducts =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return Product(
              id: doc.id,
              name: data['name']?.toString() ?? 'Unknown',
              category: data['category']?.toString() ?? 'Unknown',
              price: (data['price'] as num?)?.toDouble() ?? 0.0,
              description: data['description']?.toString() ?? 'No description',
            );
          }).toList();

      notifyListeners();
    } catch (e) {
      // Silently fail
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
    }
  }

  List<Product> get products {
    List<Product> filtered = [..._allProducts];

    if (_selectedCategory != 'All') {
      filtered =
          filtered
              .where((product) => product.category == _selectedCategory)
              .toList();
    }

    switch (_sortType) {
      case SortType.name:
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortType.priceLowToHigh:
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortType.priceHighToLow:
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
    }
    return filtered;
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSortType(SortType type) {
    _sortType = type;
    notifyListeners();
  }
}
