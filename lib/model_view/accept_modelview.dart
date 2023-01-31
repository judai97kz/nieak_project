import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/model/bill_model.dart';
import 'package:nieak_project/model_view/add_product_to_cart.dart';
import 'package:nieak_project/model_view/bill_modelview.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import 'package:nieak_project/screen/cm_screen.dart';

class AcceptModelView extends GetxController {
  var acceptstate = 0.obs;
  var acceptnull = 0.obs;
  final checkuser = Get.put(Userid());
  final getcart = Get.put(AddProductHelper());
  final pay = Get.put(BillDatabaseHelper());
  String name = "";

  void printBill() {
    for (int i = 0; i < getcart.allProduct.length; i++) {
      name += " - " +
          getcart.allProduct[i].nameproduct.toString() +
          " Size " +
          getcart.allProduct[i].sizeproduct.toString() +
          " x" +
          getcart.allProduct[i].amoutproduct.toString() +
          "\n";
    }
  }

  AcceptBill(String password,BuildContext context) {
    if (password == "") {
      acceptnull.value = 1;
    } else if (password == checkuser.user.value!.password) {
      acceptnull.value = 0;
      acceptstate.value=0;
      printBill();
      DateTime now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);
      BillModel a = BillModel(
          idbill: now.toString(),
          billtime: formattedDate,
          contentbill: name,
          pricebill: getcart.allprice.toInt());
      pay.addBill(a);
      for (int i = 0; i < getcart.allProduct.length; i++) {
        getcart.deleteProduct(getcart.allProduct[i]);
      }
      getcart.allProduct.value = [];
      getcart.allprice.value = 0;
      Navigator.of(context)
          .pushAndRemoveUntil(
          MaterialPageRoute(
              builder:
                  (context) =>
                  CMScreen()),
              (Route<dynamic>
          route) =>
          false);
    }else{
      acceptnull.value = 0;
      acceptstate.value=1;
    }
  }
}
