import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/model/bill_model.dart';
import 'package:nieak_project/model_view/add_product_to_cart.dart';
import 'package:nieak_project/model_view/bill_modelview.dart';
import 'package:nieak_project/screen/cm_screen.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
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
                                        " ----- Đơn Giá: ${getcart.allProduct[i].priceproduct}"),
                                    Text(
                                        " ----- Số Lượng: ${getcart.allProduct[i].amoutproduct}"),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      "Thành Tiền: ${getcart.allProduct[i].priceproduct * getcart.allProduct[i].amoutproduct}"),
                                )
                              ],
                            ),
                          )),
                    ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                    onTap: () {
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
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => CMScreen()),
                          (Route<dynamic> route) => false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.black)),
                      height: 40,
                      child: Center(
                          child: Text(
                        "Thanh Toán",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                    )),
              )
            ],
          )),
    );
  }
}
