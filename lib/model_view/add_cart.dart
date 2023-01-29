import 'package:get/get.dart';

class AddProductInCart extends GetxController {
  var size = 0.obs;
  var amout = 1.obs;

  @override
  void onInint() {
    super.onInit();
    amout;
    size;
    selectSize(size);
  }

  selectSize(var num) {
    size.value = num;
    print(size.toString());
  }

  addAmout() {
    amout++;
  }

  disAmout() {
    if (amout > 1) {
      amout--;
    }
  }
}
