import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/restaurant_model.dart';

class RestaurantController extends GetxController {
  var restaurants = <Restaurant>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRestaurants();
  }

  void fetchRestaurants() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('https://private-anon-1f306c826c-pizzaapp.apiary-mock.com/restaurants/'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        restaurants.value = List<Restaurant>.from(jsonData.map((x) => Restaurant.fromJson(x)));
      }
    } finally {
      isLoading(false);
    }
  }
}
