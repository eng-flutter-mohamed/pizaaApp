import 'package:get/get.dart';
import 'package:pizza_app_task/Service/api_service.dart';
import 'package:pizza_app_task/controllers/CartController.dart';
import 'package:pizza_app_task/models/menu_item_model.dart';

class ItemDetailController extends GetxController {
  final MenuItem menuItem;
  var quantity = 1.obs;
  var extraCorn = false.obs;
  var extraCheese = false.obs;
  var menuItems = <MenuItem>[].obs;

  final CartController cartController = Get.find<CartController>();

  ItemDetailController(this.menuItem) {
    fetchMenuItems();
    loadExistingItem(); 
  }

 
  double get totalPrice => menuItem.price * quantity.value +
      (extraCorn.value ? 7.0 : 0.0) +
      (extraCheese.value ? 5.0 : 0.0);

  Future<void> fetchMenuItems() async {
    try {
      List<MenuItem> items = await ApiService.fetchMenuItems(menuItem.id);
      menuItems.assignAll(items);
    } catch (e) {
 
      print("Error fetching menu items: $e");
    }
  }


  void loadExistingItem() {
    var cartItem = cartController.getItem(menuItem.id);
    if (cartItem != null) {
      quantity.value = cartItem.quantity;
      extraCorn.value = cartItem.extraCorn;
      extraCheese.value = cartItem.extraCheese;
    }
  }


  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) quantity.value--;
  }


  void toggleExtraCorn(bool value) {
    extraCorn.value = value;
  }

  
  void toggleExtraCheese(bool value) {
    extraCheese.value = value;
  }


  void addToCart() {
    cartController.addItem(menuItem, quantity.value, extraCorn.value, extraCheese.value);
  }
}
