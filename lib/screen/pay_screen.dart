import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/mini_widget/bank_widget.dart';
import 'package:nieak_project/mini_widget/select_bank.dart';

import 'package:nieak_project/model_view/add_product_to_cart.dart';
import 'package:nieak_project/model_view/bill_modelview.dart';

import 'package:nieak_project/model_view/key_cart_user.dart';

import 'package:nieak_project/model_view/accept_modelview.dart';

import 'cm_screen.dart';

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
        title: const Text("Thanh toán"),
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
                          decoration: const BoxDecoration(
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
                                SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                        getcart.allProduct[i].nameproduct)),
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
                child: SizedBox(
                  height: 140,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                      ),
                      const Text("Thông Tin Người Nhận"),
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
                            child: Text(
                                "Người Nhận: ${userinfo.user.value!.name}")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, top: 2.0, bottom: 2.0, left: 20.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "Điện Thoại: ${userinfo.user.value!.phone}")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, top: 2.0, bottom: 2.0, left: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child:
                              Text("Địa Chỉ: ${userinfo.user.value!.address}"),
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
                        child: Text(
                            "Tổng Tiền: ${myFormat.format(getcart.allprice.toInt())} "),
                      ),
                      GestureDetector(
                          onTap: () {
                            AlertDialog alert = AlertDialog(
                              title: const Text("Thông báo"),
                              content: const Text(
                                  "Bạn có muốn thanh toán hóa đơn này không?"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      AlertDialog alert = AlertDialog(
                                        title: const Text("Xác Nhận"),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              const Text("Lựa Chọn Thanh toán"),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        builder: (builder) {
                                                          return SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                const Text(
                                                                    "lựa chọn ngân hàng thanh toán"),
                                                                BankWidget(
                                                                    context),
                                                                GestureDetector(
                                                                  child: Row(
                                                                    // ignore: prefer_const_literals_to_create_immutables
                                                                    children: [
                                                                      const Icon(
                                                                          Icons
                                                                              .add),
                                                                      const Text(
                                                                          "Nạp tiền vào tài khoản!")
                                                                    ],
                                                                  ),
                                                                  onTap: () {
                                                                    SelectBank(
                                                                        context);
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: const Text(
                                                      "Thanh Toán Trực Tuyến")),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const CMScreen()),
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false);
                                                  },
                                                  child: Text(
                                                      "Thanh Toán Trực Tiếp")),
                                            ],
                                          ),
                                        ),
                                        actions: [
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
                                    },
                                    child: const Text("Đồng Ý")),
                                const SizedBox(),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Hủy"))
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
                            child: const Center(
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
