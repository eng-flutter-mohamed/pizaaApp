// /lib/views/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_app_task/views/CheckoutScreen.dart';
import '../controllers/restaurant_controller.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/category_card.dart';
import '../widgets/quick_browse_item.dart';

class HomeScreen extends StatelessWidget {
  final RestaurantController restaurantController =
      Get.find<RestaurantController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: heightScreen / 4 / 8),
              child: Container(
                color: const Color.fromARGB(255, 228, 243, 255),
                height: heightScreen / 3.08,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(38.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Delivering to",
                        style: TextStyle(fontSize: 10),
                      ),
                      const Row(
                        children: [
                          Text(
                            "6th Of October, Giza",
                            style: TextStyle(fontSize: 15),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      SizedBox(
                        height: heightScreen / 3 / 3 / 2,
                      ),
                      const Text(
                        "Hey There!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Text(
                        "log in or create account for a\nfaster ordering experience.",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: heightScreen / 3 / 3 / 5,
                      ),
                      MaterialButton(
                        shape: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        color: const Color.fromARGB(255, 2, 158, 186),
                        onPressed: () {
                          Get.to(() => const CheckoutScreen());
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // Padding واحد يبدأ هنا
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Explore Dishes
                  const Text("Explore Dishes",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: heightScreen / 3 / 3 / 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const CategoryCard(
                          imagePath: "assets/images/noodiles.png",
                          title: "Noodles",
                          backgroundColor: Color(0xFFFFCDD2),
                        ),
                        SizedBox(width: heightScreen / 8 / 5 / 2),
                        const CategoryCard(
                          imagePath: "assets/images/chicken.png",
                          title: "Grilled Chicken",
                          backgroundColor: Color(0xFFEBF4FA),
                        ),
                        SizedBox(width: heightScreen / 8 / 5 / 2),
                        const CategoryCard(
                          imagePath: "assets/images/pasta.png",
                          title: "Pasta",
                          backgroundColor: Color(0xFFEBF4FA),
                        ),
                        SizedBox(width: heightScreen / 8 / 5 / 2),
                        const CategoryCard(
                          imagePath: "assets/images/Sushi.png",
                          title: "Sushi",
                          backgroundColor: Color(0xFFEBF4FA),
                        ),
                        SizedBox(width: heightScreen / 8 / 5 / 2),
                        const CategoryCard(
                          imagePath: "assets/images/Salads.png",
                          title: "Salads",
                          backgroundColor: Color(0xFFEBF4FA),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: heightScreen / 3 / 3 / 10),

                  // Quick Browse
                  const Text("Quick Browse",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: heightScreen / 3 / 3 / 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         QuickBrowseItem(
                          onTap: (){},
                          icon: Icons.local_offer,
                          iconColor: Colors.redAccent,
                          label: "Food Offers",
                          backgroundColor: Color(0xFFFFCDD2),
                        ),
                        SizedBox(width: widthScreen / 3 / 3 / 4),
                         QuickBrowseItem(
                          onTap: (){},
                          icon: Icons.star,
                          iconColor: Colors.orange,
                          label: "Top-Rated",
                          backgroundColor: Color.fromARGB(255, 255, 251, 215),
                        ),
                        SizedBox(width: widthScreen / 3 / 3 / 4),
                         QuickBrowseItem(
                          onTap: (){
                    
                          },
                          icon: Icons.location_on,
                          iconColor: Colors.redAccent,
                          label: "Live Tracking",
                          backgroundColor: Color(0xFFFFCDD2),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: heightScreen / 3 / 3 / 10),

                  // Restaurants you know
                  const Text("Restaurants you know",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: heightScreen / 3 / 3 / 10),
                  Obx(() {
                    if (restaurantController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (restaurantController.restaurants.isEmpty) {
                      return const Center(child: Text("No restaurants found."));
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            restaurantController.restaurants.map((restaurant) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed('/restaurant-details', arguments: {
                                'restaurantId': restaurant.id,
                                'restaurantName': restaurant.name,
                              });
                            },
                            child: RestaurantCard(
                              name: restaurant.name,
                              rating: "4.5 (100+)",
                              imagePath: 'assets/images/pizza.png',
                              cuisine: 'pizza ,pasta',
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                  SizedBox(height: heightScreen / 3 / 10),
                  Card(
                    color: const Color.fromARGB(255, 2, 158, 186),
                    child: ListTile(
                      title: const Text(
                        "Free delivery, on us",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        "A gift for your first order",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: TextButton(
                        onPressed: () {
                          Get.toNamed('/checkout');
                        },
                        child: const Text(
                          "Order now",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: heightScreen / 3 / 10),

                  // Popular Today
                  const Text("Popular Today",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: heightScreen / 3 / 3 / 10),
                  Obx(() {
                    if (restaurantController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (restaurantController.restaurants.isEmpty) {
                      return const Center(child: Text("No restaurants found."));
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            restaurantController.restaurants.map((restaurant) {
                          return RestaurantCard(
                            imagePath: 'assets/images/pizza.png',
                            name: restaurant.name,
                            time: "36 mins",
                            // يمكنك تعديل الوقت حسب الحاجة
                          );
                        }).toList(),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
