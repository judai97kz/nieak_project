import 'package:get/get.dart';
import 'package:nieak_project/Respositories/cart_database.dart';
import 'package:nieak_project/model/cart_model.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';

class AddProductHelper extends GetxController {
  var allProduct = <CartModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAll();
  }

  keychange() {
    allProduct.value = [];
  }

  fetchAll() async {
    var shoes = await CartDatabase.getAllShoes();
    allProduct.value = shoes!;
  }

  addShoes(CartModel value) {
    CartDatabase.addShoes(value);
    fetchAll();
  }

  deleteProduct(CartModel value) {
    CartDatabase.deleteShoes(value);
    fetchAll();
  }
}
