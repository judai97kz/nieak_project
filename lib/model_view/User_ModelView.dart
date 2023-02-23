import 'package:get/get.dart';
import 'package:nieak_project/Respositories/user_database.dart';

import '../model/user_model.dart';

class UserModelView extends GetxController{
  var listuser = <User>[].obs;

  getUser() async {
    var list = await UserDatabaseHelper.getListUser();
    listuser.value = list!;
  }

  deleteUser(User user) async {
    await UserDatabaseHelper.deleteUser(user);
    getUser();
  }

  updateUser(User user) async {
    await UserDatabaseHelper.updateUser(user);
    getUser();
  }

}