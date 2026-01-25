class CartModel {
  final String productId;
  final String name;
  final int quantity;
  final double price;

  CartModel({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory CartModel.fromFirestore(String productId, Map<String, dynamic> data) {
    return CartModel(
      productId: productId,
      name: data['name'],
      price: (data['price'] as num).toDouble(),
      quantity: data['quantity'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {'name': name, 'price': price, 'quantity': quantity};
  }
}
