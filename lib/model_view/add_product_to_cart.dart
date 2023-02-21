import 'package:get/get.dart';
import 'package:nieak_project/Respositories/cart_database.dart';
import 'package:nieak_project/model/cart_model.dart';

class AddProductHelper extends GetxController {
  var allProduct = <CartModel>[].obs;
  var allprice = 0.obs;
  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    fetchAll();
    payProduct();
  }

  keychange() {
    allProduct.value = [];
  }

  fetchAll() async {
    var shoes = await CartDatabase.getCart();
    allProduct.value = shoes!;
    payProduct();
  }

  addShoes(CartModel value) {
    CartDatabase.addCart(value);
    fetchAll();
  }

  deleteProduct(CartModel value) {
    CartDatabase.deleteCart(value);
    fetchAll();
  }

  updateProduct(CartModel value) async {
    await CartDatabase.updateCart(value);
    fetchAll();
  }

  payProduct() {
    if (allProduct.isEmpty) {
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
