import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_app_task/Service/api_service.dart';
import 'package:pizza_app_task/controllers/CartController.dart';
import 'package:pizza_app_task/models/menu_item_model.dart';
import 'package:pizza_app_task/views/MenuItemCard.dart';
import 'package:pizza_app_task/widgets/BottomCheckoutBar.dart';


class RestaurantDetailsScreen extends StatelessWidget {
  final int restaurantId;
  final String restaurantName;

  RestaurantDetailsScreen({
    super.key,
    required this.restaurantId,
    required this.restaurantName,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    double heightScreen = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            TabController tabController = DefaultTabController.of(context);

            return Stack(
              children: [
                Column(
                  children: [
                
                    Container(
                      height: heightScreen / 3.5,
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/pizza.png",
                        height: heightScreen / 3.5,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: heightScreen / 8 / 2),
                   
                    TabBar(
                      controller: tabController,
                      labelColor: Colors.black,
                      indicatorColor: Colors.orange,
                      tabs: const [
                        Tab(text: "Appetizers"),
                        Tab(text: "Pizza"),
                        Tab(text: "Drinks"),
                      ],
                      onTap: (index) {
                        // عند الضغط على تبويب يتم التمرير إلى القسم المناسب
                        if (index == 0) {
                          Scrollable.ensureVisible(
                              appetizersKey.currentContext!,
                              duration: const Duration(milliseconds: 500));
                        } else if (index == 1) {
                          Scrollable.ensureVisible(pizzaKey.currentContext!,
                              duration: const Duration(milliseconds: 500));
                        } else if (index == 2) {
                          Scrollable.ensureVisible(drinksKey.currentContext!,
                              duration: const Duration(milliseconds: 500));
                        }
                      },
                    ),
                    
                    Expanded(
                      child: _buildMenuPage(cartController, restaurantId),
                    ),
                  ],
                ),
             
                Positioned(
                  top: heightScreen / 5.5,
                  left: 16.0,
                  right: 16.0,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/pizza.png",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurantName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Pizza, Pasta",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Icon(Icons.star,
                                        size: 14, color: Colors.orange),
                                    Text(" 4.5",
                                        style: TextStyle(color: Colors.black)),
                                    Text(" (100+)",
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("Delivery in"),
                                Text(
                                  "Free",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                        
                            SizedBox(
                              height: 50, 
                              child: VerticalDivider(
                             
                                thickness: 1, 
                              ),
                            ),
                            Column(
                              children: [
                                Text("Delivery time"),
                                Text(
                                  "36",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                        
                            SizedBox(
                              height: 50, 
                              child: VerticalDivider(
                                thickness: 1, 
                              ),
                            ),
                            Column(
                              children: [
                                Text("Delivery By"),
                                Text(
                                  "Free",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
               
           
Positioned(
  bottom: 0,
  left: 0,
  right: 0,
  child: Obx(() => BottomCheckoutBar(
    itemCount: cartController.cartItems.length, 
    totalPrice: cartController.totalPrice, 
    onCheckout: () {
    
      Get.toNamed('/checkout'); 
    },
  )),
),

              ],
            );
          },
        ),
      ),
    );
  }


  final appetizersKey = GlobalKey();
  final pizzaKey = GlobalKey();
  final drinksKey = GlobalKey();

  Widget _buildMenuPage(CartController cartController, int restaurantId) {
    return FutureBuilder<List<MenuItem>>(
      future: ApiService.fetchMenuItems(restaurantId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("خطأ: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("لا توجد عناصر قائمة."));
        }

        List<MenuItem> menuItems = snapshot.data!;
        List<MenuItem> appetizers = menuItems
            .where(
                (item) => item.category != "Pizza" && item.category != "Dryck")
            .toList();
        List<MenuItem> pizzas =
            menuItems.where((item) => item.category == "Pizza").toList();
        List<MenuItem> drinks =
            menuItems.where((item) => item.category == "Dryck").toList();

        return ListView(
          children: [
            _buildCategorySection("Appetizers", appetizers, cartController,
                appetizersKey),
            _buildCategorySection("Pizza", pizzas, cartController, pizzaKey),
            _buildCategorySection("Drinks", drinks, cartController, drinksKey),
          ],
        );
      },
    );
  }

 Widget _buildCategorySection(String title, List<MenuItem> items,
    CartController cartController, GlobalKey key) {
  return Column(
    key: key,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      items.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("لا توجد عناصر في $title",
                  style: const TextStyle(fontSize: 18, color: Colors.grey)),
            )
          : Column(
              children: items.map((menuItem) {
                return MenuItemCard(
                  menuItem: menuItem,
                  onAddToCart: () {
                 
                    int quantity = 1; 
                    bool extraCorn = false; 
                    bool extraCheese = false; 
                    
                    cartController.addItem(
                      menuItem, 
                      quantity, 
                      extraCorn, 
                      extraCheese,
                    );
                    Get.snackbar(
                      'تمت الإضافة',
                      '${menuItem.name} أضيفت إلى السلة',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                );
              }).toList(),
            ),
    ],
  );
}

}
