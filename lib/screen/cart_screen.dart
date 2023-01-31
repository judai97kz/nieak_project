import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/mini_widget/product_widget.dart';
import 'package:nieak_project/model/bill_model.dart';
import 'package:nieak_project/model_view/add_cart.dart';
import 'package:nieak_project/model_view/add_product_to_cart.dart';
import 'package:nieak_project/model_view/bill_modelview.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import 'package:nieak_project/screen/pay_screen.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  final mycart = Get.put(AddProductHelper());
  final usercart = Get.put(Userid());
  final pay = Get.put(BillDatabaseHelper());
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.orange),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                          height: 30,
                          child: Center(
                              child: Text(
                                  "Giỏ Hàng của ${usercart.user.value?.name}"))),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red)),
                      ),
                      Container(
                        width: double.infinity,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: mycart.allProduct.length,
                            itemBuilder: (context, index) {
                              print(mycart.allProduct);
                              return ProductWidget(
                                  model: mycart.allProduct[index]);
                            }),
                      ),
                      SizedBox(
                        height: 35,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(9.5),
                          bottomRight: Radius.circular(9.5)),
                    ),
                    height: 40,
                    width: double.infinity,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              "Tổng tiền: ${myFormat.format(mycart.allprice.toInt())}"),
                          SizedBox(
                            width: 20,
                          ),
                          Align(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ElevatedButton(
                                child: Text("Thanh Toán"),
                                onPressed: mycart.allProduct.length == 0
                                    ? null
                                    : () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PayScreen()));
                                      },
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
