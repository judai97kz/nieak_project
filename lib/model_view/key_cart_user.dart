import 'package:get/get.dart';
import 'package:nieak_project/model/user_model.dart';


class Userid extends GetxController {
  final user = Rxn<User>();
  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    update();
  }

  updateID(User value) {
    user.value = value;
  }
}
