import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nieak_project/Respositories/user_database.dart';
import 'package:nieak_project/model/user_model.dart';
import 'package:path/path.dart';

class SignupManagement extends GetxController {
  var textuser = 0.obs;
  var textpass = 0.obs;
  var textrepeat = 0.obs;
  var textname = 0.obs;
  var textphone = 0.obs;
  var textaddress = 0.obs;
  var checkrepeat = 0.obs;
  var checkexist = 0.obs;
  var checkallnull = 0.obs;
  checkChange(String username, String password, String repeat, String name,
      String phone, String address) async {
    if (username == "" ||
        password == "" ||
        repeat == "" ||
        name == "" ||
        phone == "" ||
        address == "") {
      checkallnull.value = 1;
    } else {
      checkallnull.value = 0;
    }
    if (repeat == "") {
      textrepeat.value = 1;
    } else {
      textrepeat.value = 0;
    }
    if (name.length < 10) {
      textname.value = 1;
    } else {
      textname.value = 0;
    }
    if (phone.length < 9) {
      textphone.value = 1;
    } else {
      textphone.value = 0;
    }
    if (address == "") {
      textaddress.value = 1;
    } else {
      textaddress.value = 0;
    }
    if (username.length >= 8 && password.length >= 8) {
      print("ok");
      if (password != repeat) {
        checkrepeat.value = 1;
      } else {
        checkrepeat.value = 0;
        if (await UserDatabaseHelper.findUser(username) == false) {
          print("Ok luon nay");
          checkexist.value = 0;
          UserDatabaseHelper.addUser(User(
              username: username,
              password: password,
              name: name,
              phone: phone,
              address: address,
              idcart: "id${username}"));
        }
        else{
          print("KO ok ti nao");
          checkexist.value = 1;
        }
      }
    }else{
      print("KO");
      if (username.length < 8) {
        textuser.value = 1;
      } else {
        textuser.value = 0;
      }
      if (password.length < 8) {
        textpass.value = 1;
      } else {
        textpass.value = 0;
      }
    }
  }
}
