import 'package:flutter/foundation.dart';
import '../model/product_model.dart';

enum SortType { name, priceLowToHigh, priceHighToLow }

class ProductsProvider extends ChangeNotifier {
  final List<Product> _allProducts = [
    Product(
      id: 'p1',
      name: 'Men T-Shirt',
      price: 29.99,
      description: 'A comfortable men\'s t-shirt.',
      category: 'Men',
    ),
    Product(
      id: 'p2',
      name: 'Women T-Shirt',
      price: 49.99,
      description: 'A stylish women\'s t-shirt.',
      category: 'Women',
    ),
  ];

  String _selectedCategory = 'All';
  String get selectedCategory => _selectedCategory;
  SortType _sortType = SortType.name;

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
