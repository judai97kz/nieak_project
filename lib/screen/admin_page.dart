import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/screen/ManagementProduct_screen.dart';
import 'package:nieak_project/screen/orderbill_screen.dart';
import 'package:nieak_project/screen/user_management_screen.dart';

import '../model_view/bill_modelview.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>UserManagementScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.green)),
                child: Center(
                  child: Align(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                            child: Icon(
                          Icons.manage_accounts,
                          size: 60,
                        )),
                        Center(
                            child: Text(
                          "Quản Lý Người Dùng",
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => ManagementProduct()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.green)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Icon(
                        Icons.shop_outlined,
                        size: 60,
                      )),
                      Center(
                          child: Text(
                        "Quản Lý Sản Phẩm",
                        textAlign: TextAlign.center,
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              final getbill = Get.put(BillDatabaseHelper());print(getbill.listorder.length);
              Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>OrderBillScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.green)),
                child: Center(
                  child: Align(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                            child: Icon(
                              Icons.shopping_cart_checkout,
                              size: 60,
                            )),
                        Center(
                            child: Text(
                              "Quản Lý Đơn Hàng",
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
