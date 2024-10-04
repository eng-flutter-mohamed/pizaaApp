import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_app_task/controllers/CartController.dart';
import 'package:pizza_app_task/controllers/OrderController.dart';
import 'package:pizza_app_task/views/CheckoutScreen.dart';

import 'package:pizza_app_task/views/RestaurantDetailsScreen.dart';
import 'controllers/restaurant_controller.dart';
import 'views/home_screen.dart';

void main() {
  runApp(PizzaApp());
}

class PizzaApp extends StatelessWidget {
  // Creating initial instances of the Controllers
  final RestaurantController restaurantController = Get.put(RestaurantController());
  final CartController cartController = Get.put(CartController());
  final OrderController orderController = Get.put(OrderController());

   PizzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pizza App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/restaurant-details', page: () => RestaurantDetailsScreen(
          restaurantId: Get.arguments['restaurantId'],
          restaurantName: Get.arguments['restaurantName'],
        )),
        GetPage(name: '/checkout', page: () => const CheckoutScreen()),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white, // Set primary color to white
        scaffoldBackgroundColor: Colors.white, // Set background color to white
       // hintColor: Colors.purple[300], // Light purple accent color
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Default text color
          bodyMedium: TextStyle(color: Colors.black54), // Secondary text color
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // Purple color for AppBar
          titleTextStyle: TextStyle(color: Colors.white), // White title text
        ),
      ),
    );
  }
}
