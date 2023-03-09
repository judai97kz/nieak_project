import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:nieak_project/mini_widget/bill_widget.dart';
import 'package:nieak_project/mini_widget/orderbill_widget.dart';
import 'package:nieak_project/model_view/add_cart.dart';
import 'package:nieak_project/model_view/bill_modelview.dart';

class OrderBillScreen extends StatefulWidget {
  const OrderBillScreen({super.key});

  @override
  State<OrderBillScreen> createState() => _OrderBillScreenState();
}

class _OrderBillScreenState extends State<OrderBillScreen> {
  final getbill = Get.put(BillDatabaseHelper());
  final delcart = Get.put(AddProductInCart());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Đơn Hàng")),
      body: Obx(() => ListView.builder(
          itemCount: getbill.listorder.length,
          itemBuilder: ((context, index) {
            final item = getbill.listorder[index];
            return Dismissible(
                key: Key(item.idbill.toString()),
                confirmDismiss: (direction) {
                  AlertDialog alert = AlertDialog(
                    title: const Text("Thông báo"),
                    content:
                    const Text("Bạn có muốn xóa sản phẩm này ra khỏi giỏ hàng?"),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            getbill.deleteOrderBill(item);
                            getbill.listorder.value = [];
                            getbill.getOrderBill();
                            Navigator.of(context).pop(true);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Đã xóa đơn hàng')));
                          },
                          child: const Text("Đồng Ý")),
                      const SizedBox(),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text("Hủy"))
                    ],
                  );

                  return showDialog(
                      context: context, builder: (context) => alert);
                },
                onDismissed: (direction) {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: miniOrderBill(getbill.listorder[index]),
                ));
          }))),
    );
  }
}
