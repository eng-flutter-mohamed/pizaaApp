import 'package:get/get.dart';
import '../models/menu_item_model.dart';

class CartItem {
  MenuItem? menuItem;
  int quantity;
  bool extraCorn;
  bool extraCheese;

  CartItem({
    required this.menuItem,
    required this.quantity,
    this.extraCorn = false,
    this.extraCheese = false,
  });
}

class CartController extends GetxController {

  var cartItems = <CartItem>[].obs;


  CartItem? getItem(int itemId) {
    try {
      return cartItems.firstWhere((item) => item.menuItem!.id == itemId);
    } catch (e) {
      return null; 
    }
  }


  void addItem(MenuItem menuItem, int quantity, bool extraCorn, bool extraCheese) {
    var index = cartItems.indexWhere((item) => item.menuItem!.id == menuItem.id);
    if (index != -1) {
     
      cartItems[index].quantity += quantity; 
      cartItems[index].extraCorn = extraCorn;
      cartItems[index].extraCheese = extraCheese;
    } else {
   
      cartItems.add(CartItem(
        menuItem: menuItem,
        quantity: quantity,
        extraCorn: extraCorn,
        extraCheese: extraCheese,
      ));
    }
  }

 
  void removeItem(CartItem cartItem) {
    cartItems.remove(cartItem);
  }


  double get totalPrice {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item.menuItem!.price * item.quantity) +
          (item.extraCorn ? 7.0 : 0.0) +
          (item.extraCheese ? 5.0 : 0.0),
    );
  }


  void clearCart() {
    cartItems.clear();
  }
}
