import 'package:get/get.dart';

class DropListState extends GetxController{
  // ignore: non_constant_identifier_names
  var BankState = "".obs;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    BankState.value = "MB Bank";
  }
}