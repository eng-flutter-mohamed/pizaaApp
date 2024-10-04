// /lib/controllers/menu_item_controller.dart
import 'package:get/get.dart';
import '../models/menu_item_model.dart';
import '../Service/api_service.dart';

class MenuItemController extends GetxController {
  var isLoading = true.obs;
  var menuItems = <MenuItem>[].obs;

  void fetchMenuItems(int restaurantId, {String category = '', String orderBy = ''}) async {
    try {
      isLoading(true);
      var fetchedMenuItems = await ApiService.fetchMenuItems(restaurantId, category: category, orderBy: orderBy);
      if (fetchedMenuItems != null) {
        menuItems.assignAll(fetchedMenuItems);
      }
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
