import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/mini_widget/product_widget.dart';

import 'package:nieak_project/model_view/add_product_to_cart.dart';
import 'package:nieak_project/model_view/bill_modelview.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import 'package:nieak_project/screen/pay_screen.dart';

import 'bill_screen.dart';

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
      appBar: AppBar(
        title: const Text("Giỏ Hàng"),
        backgroundColor: Colors.orange,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyBill()));
              },
              child: Icon(Icons.shopping_basket),
            ),
          )
        ],
      ),
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
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                          height: 30,
                          child: Center(
                              child: Text(
                                  "Giỏ Hàng của ${usercart.user.value?.name}"))),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red)),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: mycart.allProduct.length,
                            itemBuilder: (context, index) {
                              return ProductWidget(
                                  model: mycart.allProduct[index]);
                            }),
                      ),
                      const SizedBox(
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
                      borderRadius: const BorderRadius.only(
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
                          const SizedBox(
                            width: 20,
                          ),
                          Align(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ElevatedButton(
                                // ignore: sort_child_properties_last
                                child: const Text("Thanh Toán"),
                                onPressed: mycart.allProduct.isEmpty
                                    ? null
                                    : () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PayScreen()));
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
