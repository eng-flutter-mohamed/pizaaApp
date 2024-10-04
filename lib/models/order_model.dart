// /lib/models/order_model.dart
class Order {
  final int orderId;
  final double totalPrice;
  final String orderedAt;
  final String esitmatedDelivery;
  final String status;
  final List<CartItem> cart;
  final int restaurantId;

  Order({
    required this.orderId,
    required this.totalPrice,
    required this.orderedAt,
    required this.esitmatedDelivery,
    required this.status,
    required this.cart,
    required this.restaurantId,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      orderedAt: json['orderedAt'],
      esitmatedDelivery: json['esitmatedDelivery'],
      status: json['status'],
      cart: (json['cart'] as List).map((item) => CartItem.fromJson(item)).toList(),
      restaurantId: json['restuarantId'],
    );
  }
}

class CartItem {
  final int menuItemId;
  final int quantity;

  CartItem({
    required this.menuItemId,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      menuItemId: json['menuItemId'],
      quantity: json['quantity'],
    );
  }
}
