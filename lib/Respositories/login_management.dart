import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nieak_project/Respositories/user_database.dart';
import 'package:path/path.dart';

class LoginManagement extends GetxController {
  var textuser = 0.obs;
  var textpass = 0.obs;
  checkChange(String username, String password, BuildContext context) {
    if (username == "" || username.length < 8) {
      textuser.value = 1;
    } else {
      textuser.value = 0;
    }
    if (password == "" || password.length < 8) {
      textpass.value = 1;
    } else {
      textpass.value = 0;
    }
    if (username != "" &&
        username.length >= 8 &&
        password.length >= 8 &&
        password != "") {
      UserDatabaseHelper.getAllUser(username, password, context);
    }
  }
}
