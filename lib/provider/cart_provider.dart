import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monther_shop_mobile_flutter/model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<CartModel> _items = [];
  List<CartModel> get items => _items;

  Future<void> fetchCartItems() async {
    final snapshot = await _firestore.collection('cart').get();

    _items =
        snapshot.docs
            .map((doc) => CartModel.fromFirestore(doc.id, doc.data()))
            .toList();
    notifyListeners();
  }

  Future<void> addToCart({
    required String productId,
    required String name,
    required double price,
  }) async {
    final docRef = _firestore.collection('cart').doc(productId);
    final doc = await docRef.get();

    if (doc.exists) {
      final currentQuantity = doc['quantity'] as int;

      await docRef.update({'quantity': currentQuantity + 1});
    } else {
      await docRef.set({'name': name, 'price': price, 'quantity': 1});
    }
    await fetchCartItems();
  }

  Future<void> decreaseQuantity(String productId) async {
    final docRef = _firestore.collection('cart').doc(productId);
    final doc = await docRef.get();

    if (!doc.exists) return;

    final currentQuantity = doc['quantity'] as int;

    if (currentQuantity > 1) {
      await docRef.update({'quantity': currentQuantity - 1});
    } else {
      await docRef.delete();
    }

    await fetchCartItems();
  }

  Future<void> removeItem(String productId) async {
    await _firestore.collection('cart').doc(productId).delete();
    await fetchCartItems();
  }

  Future<void> clearCart() async {
    final snapshot = await _firestore.collection('cart').get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }

    _items = [];
    notifyListeners();
  }

  double get totalPrice {
  double total = 0;
  for (final item in _items) {
    total += item.price * item.quantity;
  }
  return total;
}
}
