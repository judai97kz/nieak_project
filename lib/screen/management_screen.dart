import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nieak_project/screen/cart_screen.dart';
import 'package:nieak_project/screen/home_page.dart';
import 'package:nieak_project/screen/user_page.dart';
import '../model_view/add_product_to_cart.dart';
import '../model_view/home_modelview.dart';

class Managementpage extends StatefulWidget {
  const Managementpage({Key? key}) : super(key: key);
  @override
  State<Managementpage> createState() => _ManagementpageState();
}

class _ManagementpageState extends State<Managementpage> {
  final homemana = Get.put(HomeModel());
  final cartView = Get.put(AddProductHelper());
  var _screen = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _screen = [HomePage(), MyCart(), UserPage()];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[homemana.currentindex.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homemana.currentindex.value,
        onTap: (index) => setState(() {
          print(index);
          homemana.currentindex.value = index;
        }),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.shopping_cart),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Obx(() => Padding(
                            padding: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? EdgeInsets.fromLTRB(0, 0, 45, 20)
                                : EdgeInsets.fromLTRB(0, 0, 95, 0),
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.red,
                              child: Text(
                                "${cartView.allProduct.length}",
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ))),
                ],
              ),
              label: 'Cart',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá Nhân')
        ],
      ),
    );
  }
}
