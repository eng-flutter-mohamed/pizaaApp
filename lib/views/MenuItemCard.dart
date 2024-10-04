import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_app_task/views/ItemDetailScreen.dart';
import '../models/menu_item_model.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem menuItem;
  final VoidCallback onAddToCart;

  const MenuItemCard({
    super.key,
    required this.menuItem,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {
          if (menuItem != null) {
            Get.to(() => ItemDetailScreen(menuItem: menuItem));
          } else {
            Get.snackbar("Error", "Menu item is not available.");
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menuItem.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          "EGP ${menuItem.price}",
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          (menuItem.toppings != null &&
                                  menuItem.toppings!.isNotEmpty)
                              ? menuItem.toppings!.join(", ")
                              : "Delicious pizza with no specific toppings.",
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      "assets/images/pizza.png", 
                      width: widthScreen / 3,
                      height: widthScreen / 3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
