import 'package:get/get.dart';

class AddProductInCart extends GetxController {
  var size = 0.obs;
  var amout = 1.obs;

  void onInint() {
    super.onInit();
    amout;
    size;
    selectSize(size);
  }

  // ignore: avoid_types_as_parameter_names
  selectSize(var num) {
    size.value = num;

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
