import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/Respositories/user_database.dart';
import 'package:nieak_project/model/bill_model.dart';
import 'package:nieak_project/model/user_model.dart';
import 'package:nieak_project/model_view/add_product_to_cart.dart';
import 'package:nieak_project/model_view/bill_modelview.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import 'package:nieak_project/screen/cm_screen.dart';

class AcceptModelView extends GetxController {
  var acceptstate = 0.obs;
  var acceptnull = 0.obs;
  var checkuser = Get.put(Userid());
  final getcart = Get.put(AddProductHelper());
  final pay = Get.put(BillDatabaseHelper());
  String name = "";

  void printBill() {
    for (int i = 0; i < getcart.allProduct.length; i++) {
      // ignore: prefer_interpolation_to_compose_strings
      name += " - " +
          getcart.allProduct[i].nameproduct.toString() +
          " Size " +
          getcart.allProduct[i].sizeproduct.toString() +
          " x" +
          getcart.allProduct[i].amoutproduct.toString() +
          "\n";
    }
  }

  // ignore: non_constant_identifier_names
  AcceptBill(String password, BuildContext context) async {
    if (password == "") {
      acceptnull.value = 1;
    } else if (password == checkuser.user.value!.password) {
      acceptnull.value = 0;
      acceptstate.value = 0;
      printBill();
      DateTime now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);
      BillModel a = BillModel(
          idbill: now.toString(),
          billtime: formattedDate,
          contentbill: name,
          pricebill: getcart.allprice.toInt());
      pay.addBill(a);
      User upuser = User(
          username: checkuser.user.value!.username,
          password: checkuser.user.value!.password,
          name: checkuser.user.value!.name,
          phone: checkuser.user.value!.phone,
          address: checkuser.user.value!.address,
          idcart: checkuser.user.value!.idcart,
          role: checkuser.user.value!.role,
          wallet:
              checkuser.user.value!.wallet.toInt() - getcart.allprice.toInt());
     await UserDatabaseHelper.updateUser(upuser);
      checkuser.updateID(upuser);
      for (int i = 0; i < getcart.allProduct.length; i++) {
        getcart.deleteProduct(getcart.allProduct[i]);
      }
      getcart.allProduct.value = [];
      getcart.allprice.value = 0;
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const CMScreen()),
          (Route<dynamic> route) => false);
    } else {
      acceptnull.value = 0;
      acceptstate.value = 1;
    }
  }
}
