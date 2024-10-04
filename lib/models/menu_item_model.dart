// /lib/models/menu_item_model.dart
class MenuItem {
  final int id;
  final String category;
  final String name;
  final List<String>? toppings;
  final double price;
  final int? rank;

  MenuItem({
    required this.id,
    required this.category,
    required this.name,
    this.toppings,
    required this.price,
    this.rank,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      category: json['category'] ?? '',
      name: json['name'] ?? '',
      toppings: json['topping'] != null ? List<String>.from(json['topping']) : null,
      price: (json['price'] as num).toDouble(),
      rank: json['rank'],
    );
  }
}
