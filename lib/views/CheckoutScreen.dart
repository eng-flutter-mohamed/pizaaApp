import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_app_task/Service/api_service.dart';
import 'package:pizza_app_task/controllers/CartController.dart';
import 'package:pizza_app_task/controllers/ItemDetailController.dart';
import 'package:pizza_app_task/controllers/OrderController.dart';
import 'package:pizza_app_task/models/menu_item_model.dart';
import 'package:pizza_app_task/models/order_model.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemDetailController controller = Get.find<ItemDetailController>();
    final CartController cartController = Get.find<CartController>();
    final OrderController orderController = Get.put(OrderController());
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (cartController.cartItems.isEmpty) {
                return const Center(child: Text("No items in the cart"));
              }
              return ListView.builder(
                shrinkWrap: true, 
                physics: const NeverScrollableScrollPhysics(), 
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];
                  return ListTile(
                    leading: Image.asset(
                      "assets/images/pizza.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.menuItem?.name ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Closed"),
                        Text("EGP ${item.menuItem?.price ?? 0.0}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () {
                            cartController.removeItem(item);
                          },
                        ),
                        Text('${item.quantity}'),
                        IconButton(
                          icon: const Icon(Icons.add_circle),
                          onPressed: () {
                            cartController.addItem(
                              item.menuItem!,
                              1,
                              item.extraCorn,
                              item.extraCheese,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
            
         
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'People usually order these items as well',
                style: TextStyle(fontSize: 12),
              ),
            ),
            
            Obx(() {
              if (controller.menuItems.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: controller.menuItems.map((menuItem) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    "assets/images/pizza.png",
                                    width: MediaQuery.of(context).size.width / 3,
                                    height: MediaQuery.of(context).size.width / 3,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  menuItem.name,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                Text(
                                  "EGP ${menuItem.price}",
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                                MaterialButton(
                                  color: const Color.fromARGB(255, 2, 158, 186),
                                  onPressed: () {
                                   
                                  },
                                  child: const Text(
                                    "+ Add",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
            }),
        
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Subtotal"),
                      Text("EGP ${cartController.totalPrice}"),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Free Delivery"),
                      Text("EGP 0.00"),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Service"),
                      Text("EGP 7.30"),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Amount",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "EGP ${cartController.totalPrice + 7.30}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // زر الدفع
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (cartController.cartItems.isEmpty) {
                    Get.snackbar("Basket is empty", "Please add items before checkout");
                    return;
                  }
                  try {
                    List<MenuItem> menuItems = cartController.cartItems
                        .map((cartItem) => cartItem.menuItem)
                        .where((menuItem) => menuItem != null)
                        .cast<MenuItem>()
                        .toList();

                    Order newOrder = await ApiService.placeOrder(menuItems, 1);
                    orderController.setOrder(newOrder);
                    Get.toNamed('/order-tracking', arguments: newOrder.orderId);
                    cartController.clearCart();
                    Get.snackbar("Order placed", "Your order has been placed successfully");
                  } catch (e) {
                    Get.snackbar("Error", "Failed to place the order: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Checkout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
