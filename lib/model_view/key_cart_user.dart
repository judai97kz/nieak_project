import 'package:get/get.dart';

class Userid extends GetxController {
  var idcart = "".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    idcart;
    update();
  }

  updateID(var id) {
    idcart.value = id;
  }
}
