import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  late List<Product> _allProducts;
  late List<Product> _filteredProducts;

  String _selectedCategory = 'All';
  String _sortBy = 'name';
  RangeValues _priceRange = const RangeValues(0, 1000);

  final List<String> categories = [
    'All',
    'Men',
    'Women',
    'Children'
  ];
  final List<String> sortOptions = [
    'name',
    'price_low',
    'price_high',
    'newest'
  ];

  List<Product> get filteredProducts => _filteredProducts;
  String get selectedCategory => _selectedCategory;
  String get sortBy => _sortBy;
  RangeValues get priceRange => _priceRange;
  List<Product> get allProducts => _allProducts;

  ProductProvider() {
    _initializeSampleData();
    _applyFiltersAndSort();
  }

  void _initializeSampleData() {
    _allProducts = [
      Product(
        id: '1',
        name: 'Classic Crew T-Shirt',
        description: 'Soft cotton crew t-shirt with regular fit',
        price: 24.99,
        category: 'Men',
        imageUrl: 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=800&q=80',
      ),
      Product(
        id: '2',
        name: 'Summer Dress',
        description: 'Lightweight summer dress with floral print',
        price: 49.99,
        category: 'Women',
        imageUrl: 'https://images.unsplash.com/photo-1520975913142-8b9b0a2f3c3a?w=800&q=80',
      ),
      Product(
        id: '3',
        name: 'Kids Hoodie',
        description: 'Cozy hoodie for children with soft lining',
        price: 34.99,
        category: 'Children',
        imageUrl: 'https://images.unsplash.com/photo-1520975913143-4f5f9c6d5d9a?w=800&q=80',
      ),
      Product(
        id: '4',
        name: 'Denim Jeans',
        description: 'Slim-fit denim jeans with stretch',
        price: 59.99,
        category: 'Men',
        imageUrl: 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?w=800&q=80',
      ),
      Product(
        id: '5',
        name: 'Leather Jacket',
        description: 'Premium faux-leather biker jacket',
        price: 129.99,
        category: 'Women',
        imageUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=800&q=80',
      ),
      Product(
        id: '6',
        name: 'Casual Sneakers',
        description: 'Comfortable everyday sneakers',
        price: 69.99,
        category: 'Men',
        imageUrl: 'https://images.unsplash.com/photo-1528701800489-476f0b6b1b0f?w=800&q=80',
      ),
      Product(
        id: '7',
        name: 'Summer Shorts',
        description: 'Light cotton shorts for warm days',
        price: 29.99,
        category: 'Children',
        imageUrl: 'https://images.unsplash.com/photo-1503342452485-86a6b8b5f6f0?w=800&q=80',
      ),
      Product(
        id: '8',
        name: 'Knitted Beanie',
        description: 'Warm knitted beanie hat',
        price: 19.99,
        category: 'Women',
        imageUrl: 'https://images.unsplash.com/photo-1519744792095-2f2205e87b6f?w=800&q=80',
      ),
    ];
  }

  void setCategory(String category) {
    _selectedCategory = category;
    _applyFiltersAndSort();
  }

  void setSortBy(String sort) {
    _sortBy = sort;
    _applyFiltersAndSort();
  }

  void setPriceRange(RangeValues range) {
    _priceRange = range;
    _applyFiltersAndSort();
  }

  void resetFilters() {
    _selectedCategory = 'All';
    _priceRange = const RangeValues(0, 1000);
    _applyFiltersAndSort();
  }

  void _applyFiltersAndSort() {
    _filteredProducts = _allProducts.where((product) {
      if (_selectedCategory != 'All' &&
          product.category != _selectedCategory) {
        return false;
      }

      if (product.price < _priceRange.start ||
          product.price > _priceRange.end) {
        return false;
      }

      return true;
    }).toList();

    switch (_sortBy) {
      case 'price_low':
        _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'newest':
        _filteredProducts.sort((a, b) => b.id.compareTo(a.id));
        break;
      case 'name':
      default:
        _filteredProducts.sort((a, b) => a.name.compareTo(b.name));
    }

    notifyListeners();
  }

  String getSortLabel(String sort) {
    switch (sort) {
      case 'price_low':
        return 'Price: Low to High';
      case 'price_high':
        return 'Price: High to Low';
      case 'newest':
        return 'Newest';
      case 'name':
      default:
        return 'Name';
    }
  }
}
