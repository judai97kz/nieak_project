import 'package:get/get.dart';
import 'package:nieak_project/Respositories/cart_database.dart';
import 'package:nieak_project/model/cart_model.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';

class AddProductHelper extends GetxController {
  var allProduct = <CartModel>[].obs;
  var allprice = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAll();
    payProduct();
  }

  keychange() {
    allProduct.value = [];
  }

  fetchAll() async {
    var shoes = await CartDatabase.getAllShoes();
    allProduct.value = shoes!;
    payProduct();
  }

  addShoes(CartModel value) {
    CartDatabase.addShoes(value);
    fetchAll();
  }

  deleteProduct(CartModel value) {
    CartDatabase.deleteShoes(value);
    fetchAll();
  }

  payProduct() {
    print("legth ${allProduct.length}");
    if (allProduct.length == 0) {
      allprice.value = 0;
    } else {
      allprice.value = 0;
      for (int i = 0; i < allProduct.length; i++) {
        allprice.value = allprice.value +
            allProduct[i].priceproduct * allProduct[i].amoutproduct;
      }
    }
  }
}
