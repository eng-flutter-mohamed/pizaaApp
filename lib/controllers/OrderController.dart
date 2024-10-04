// /lib/controllers/order_controller.dart
import 'package:get/get.dart';
import '../models/order_model.dart';
import '../Service/api_service.dart';

class OrderController extends GetxController {
  var isLoading = true.obs;
  var order = Order(orderId: 0, totalPrice: 0, orderedAt: '', esitmatedDelivery: '', status: '', cart: [], restaurantId: 0).obs;

  void setOrder(Order newOrder) {
    order.value = newOrder;
  }

  void fetchOrderDetails(int orderId) async {
    try {
      isLoading(true);
      var fetchedOrder = await ApiService.fetchOrderDetails(orderId);
      if (fetchedOrder != null) {
        order.value = fetchedOrder;
      }
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
