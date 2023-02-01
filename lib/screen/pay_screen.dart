import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/model/bill_model.dart';
import 'package:nieak_project/model_view/add_product_to_cart.dart';
import 'package:nieak_project/model_view/bill_modelview.dart';
import 'package:nieak_project/model_view/hide_modelview.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import 'package:nieak_project/screen/cm_screen.dart';
import 'package:nieak_project/model_view/accept_modelview.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final getcart = Get.put(AddProductHelper());
  final pay = Get.put(BillDatabaseHelper());
  final userinfo = Get.put(Userid());
  final accept = Get.put(AcceptModelView());
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thanh toán"),
      ),
      body: Obx(() => Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < getcart.allProduct.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(),
                                left: BorderSide(),
                                top: BorderSide(color: Colors.white),
                                right: BorderSide()),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              children: [
                                Container(
                                    width: double.infinity,
                                    child: Text(
                                        "${getcart.allProduct[i].nameproduct}")),
                                Row(
                                  children: [
                                    Text(
                                        "Size: ${getcart.allProduct[i].sizeproduct}"),
                                    Text(
                                        " ----- Đơn Giá: ${myFormat.format(getcart.allProduct[i].priceproduct)}"),
                                    Text(
                                        " ----- Số Lượng: ${getcart.allProduct[i].amoutproduct.toInt()}"),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      "Thành Tiền: ${myFormat.format(getcart.allProduct[i].priceproduct * getcart.allProduct[i].amoutproduct)}"),
                                )
                              ],
                            ),
                          )),
                    ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 140,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                      ),
                      Container(
                        child: Text("Thông Tin Người Nhận"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 80.0, top: 2.0, bottom: 2.0, left: 20.0),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              child: Text(
                                  "Người Nhận: ${userinfo.user.value!.name}"),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, top: 2.0, bottom: 2.0, left: 20.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                  "Điện Thoại: ${userinfo.user.value!.phone}"),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, top: 2.0, bottom: 2.0, left: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                                "Địa Chỉ: ${userinfo.user.value!.address}"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          child: Text(
                              "Tổng Tiền: ${myFormat.format(getcart.allprice.toInt())} "),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            AlertDialog alert = AlertDialog(
                              title: Text("Thông báo"),
                              content: Text(
                                  "Bạn có muốn thanh toán hóa đơn này không?"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      final checkacept =
                                          TextEditingController();
                                      final checkHide = Get.put(HideModelView());
                                      AlertDialog alert = AlertDialog(
                                        title: Text("Xác Nhận"),
                                        content: Obx(
                                          () => SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(
                                                    "Nhập Mật Khẩu Để Xác Nhận"),
                                                Stack(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: TextField(
                                                        obscureText: checkHide.hideaccept.value == 1?false:true,
                                                        decoration: InputDecoration(
                                                            errorText: accept
                                                                .acceptnull ==
                                                                1
                                                                ? "Không Được Để Trống!"
                                                                : accept.acceptstate ==
                                                                1
                                                                ? "Mật Khẩu Không Chính Xác!"
                                                                : null),
                                                        controller: checkacept,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Padding(
                                                        padding: EdgeInsets.fromLTRB(10, 18, 10, 0),
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
                                                accept.AcceptBill(
                                                    checkacept.text, context);
                                              },
                                              child: Text("Xác Nhận")),
                                          SizedBox(),
                                          ElevatedButton(
                                              onPressed: () {
                                                accept.acceptstate.value = 0;
                                                accept.acceptnull.value = 0;
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Hủy"))
                                        ],
                                      );

                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) => alert);
                                    },
                                    child: Text("Đồng Ý")),
                                SizedBox(),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Hủy"))
                              ],
                            );
                            showDialog(
                                context: context, builder: (context) => alert);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                border: Border.all(color: Colors.black)),
                            height: 40,
                            child: Center(
                                child: Text(
                              "Thanh Toán",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            )),
                          )),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
