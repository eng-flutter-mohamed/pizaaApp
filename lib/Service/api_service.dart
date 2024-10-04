// /lib/Service/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant_model.dart';
import '../models/menu_item_model.dart';
import '../models/order_model.dart';

class ApiService {
  static const String baseUrl = 'https://private-anon-1f306c826c-pizzaapp.apiary-mock.com';


  static Future<List<Restaurant>> fetchRestaurants() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/restaurants/'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((restaurant) => Restaurant.fromJson(restaurant)).toList();
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      print(e);
      throw Exception('Error fetching restaurants');
    }
  }

 
  static Future<List<MenuItem>> fetchMenuItems(int restaurantId, {String category = '', String orderBy = ''}) async {
    try {
      String url = '$baseUrl/restaurants/$restaurantId/menu';
      Map<String, String> queryParams = {};
      if (category.isNotEmpty) queryParams['category'] = category;
      if (orderBy.isNotEmpty) queryParams['orderBy'] = orderBy;
      Uri uri = Uri.parse(url).replace(queryParameters: queryParams);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((menuItem) => MenuItem.fromJson(menuItem)).toList();
      } else {
        throw Exception('Failed to load menu items');
      }
    } catch (e) {
      print(e);
      throw Exception('Error fetching menu items');
    }
  }


  static Future<Order> placeOrder(List<MenuItem> cartItems, int restaurantId) async {
    try {
      final cartData = cartItems.map((item) => {'menuItemId': item.id, 'quantity': 1}).toList();
      final response = await http.post(
        Uri.parse('$baseUrl/orders'),
        body: jsonEncode({
          'cart': cartData,
          'restaurantId': restaurantId,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Order.fromJson(data);
      } else {
        throw Exception('Failed to place order');
      }
    } catch (e) {
      print(e);
      throw Exception('Error placing order');
    }
  }

  static Future<Order> fetchOrderDetails(int orderId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/orders/$orderId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Order.fromJson(data);
      } else {
        throw Exception('Failed to fetch order details');
      }
    } catch (e) {
      print(e);
      throw Exception('Error fetching order details');
    }
  }
}
