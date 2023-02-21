import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/model_view/add_product_to_cart.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import '../model_view/accept_modelview.dart';
import '../model_view/hide_modelview.dart';

// ignore: non_constant_identifier_names
Widget BankWidget(BuildContext context) {
  final walletuser = Get.put(Userid());
  final billvalue = Get.put(AddProductHelper());
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: GestureDetector(
        onTap: () {
          if (walletuser.user.value!.wallet < billvalue.allprice.toInt()) {
            AlertDialog alert = AlertDialog(
              title: const Text("Không thành công"),
              content: const Text("Số dư trong tài khoản không đủ!"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Hủy"))
              ],
            );
            showDialog(context: context, builder: (context) => alert);
          } else {
            final checkacept = TextEditingController();
            final checkHide = Get.put(HideModelView());
            final accept = Get.put(AcceptModelView());
            AlertDialog alert = AlertDialog(
              content: Obx(
                () => SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text("Nhập Mật Khẩu Để Xác Nhận"),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              obscureText: checkHide.hideaccept.value == 1
                                  ? false
                                  : true,
                              decoration: InputDecoration(
                                  // ignore: unrelated_type_equality_checks
                                  errorText: accept.acceptnull == 1
                                      ? "Không Được Để Trống!"
                                      // ignore: unrelated_type_equality_checks
                                      : accept.acceptstate == 1
                                          ? "Mật Khẩu Không Chính Xác!"
                                          : null),
                              controller: checkacept,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 18, 10, 0),
                              child: GestureDetector(
                                onTap: () {
                                  checkHide.updateinaccept();
                                },
                                child: Icon(checkHide.hideaccept.value == 1
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      accept.AcceptBill(checkacept.text, context);
                    },
                    child: const Text("Xác Nhận")),
                const SizedBox(),
                ElevatedButton(
                    onPressed: () {
                      accept.acceptstate.value = 0;
                      accept.acceptnull.value = 0;
                      Navigator.of(context).pop();
                    },
                    child: const Text("Hủy"))
              ],
            );

            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => alert);
          }
        },
        child: Column(
          children: [
            const Text("Ví Tiền Điện tử NieBank"),
            Obx(() => Text(
                "Số dư còn lại: ${myFormat.format(walletuser.user.value!.wallet)}"))
          ],
        ),
      ),
    ),
  );
}
