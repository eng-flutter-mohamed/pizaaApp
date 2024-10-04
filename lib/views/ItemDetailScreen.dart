import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_app_task/controllers/ItemDetailController.dart';
import 'package:pizza_app_task/models/menu_item_model.dart';
import 'package:pizza_app_task/widgets/BottomCheckoutBar.dart';

class ItemDetailScreen extends StatelessWidget {
  final MenuItem menuItem;

  const ItemDetailScreen({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    final ItemDetailController controller = Get.put(ItemDetailController(menuItem));

    double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Image.asset("assets/images/pizza.png"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
           
                        Text(
                          menuItem.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          "Delicious pizza with extra cheese and corn. Made with fresh ingredients.",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),

                        Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price: EGP ${menuItem.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child: IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: controller.decrementQuantity,
                                      ),
                                    ),
                                    SizedBox(
                                      width: widthScreen / 8,
                                      child: Center(
                                        child: Text(
                                          '${controller.quantity.value}',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor:    const Color.fromARGB(255, 2, 158, 186),
                                      child: IconButton(
                                        color: Colors.white,
                                        icon: const Icon(Icons.add),
                                        onPressed: controller.incrementQuantity,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),

                        const SizedBox(height: 20),

                        Obx(() => CheckboxListTile(
                              title: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Extra Corn", style: TextStyle(fontSize: 14)),
                                  Text("(EGP 7.0)", style: TextStyle(fontSize: 12)),
                                ],
                              ),
                              value: controller.extraCorn.value,
                              onChanged: (value) => controller.toggleExtraCorn(value!),
                            )),

                     
                        Obx(() => CheckboxListTile(
                              title: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Extra Cheese", style: TextStyle(fontSize: 14)),
                                  Text("(EGP 5.0)", style: TextStyle(fontSize: 12)),
                                ],
                              ),
                              value: controller.extraCheese.value,
                              onChanged: (value) => controller.toggleExtraCheese(value!),
                            )),

                      

                        const Text(
                          'People usually order these items as well',
                          style: TextStyle(fontSize: 12),
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
                                      width: widthScreen / 3,
                                      child: Card(
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10.0),
                                              child: Image.asset(
                                                "assets/images/pizza.png",
                                                width: widthScreen / 3,
                                                height: widthScreen / 3,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() => BottomCheckoutBar(
                itemCount: controller.quantity.value, 
                totalPrice: controller.totalPrice, 
                onCheckout: () {
                  controller.addToCart(); 
                  Get.toNamed('/checkout');
                },
              )),
        ],
      ),
    );
  }
}
