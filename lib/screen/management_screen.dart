import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nieak_project/model_view/brand_modelview.dart';
import 'package:nieak_project/model_view/image_modelview.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import 'package:nieak_project/screen/admin_page.dart';
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
  final roleuser = Get.put(Userid());
  final getallbrand = Get.put(BrandModelView());
  final getallimages = Get.put(ImageModelView());
  var _screen = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getallbrand.getBrand();
    getallimages.getImage();
    _screen = [
      HomePage(),
      MyCart(),
      UserPage(),
      roleuser.user.value!.role == 1 ? AdminPage() : null
    ];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screen[homemana.currentindex.value],
        bottomNavigationBar: roleuser.user.value!.role == 1
            ? BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
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
                      icon: Stack(children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.shopping_cart),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Obx(() => Padding(
                                  padding: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? roleuser.user.value!.role == 1
                                          ? EdgeInsets.fromLTRB(0, 0, 25, 15)
                                          : EdgeInsets.fromLTRB(0, 0, 45, 20)
                                      : roleuser.user.value!.role == 1
                                          ? EdgeInsets.fromLTRB(0, 0, 65, 0)
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
                      ]),
                      label: 'Cart',
                      backgroundColor: Colors.red),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Cá Nhân'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.admin_panel_settings), label: 'Admin')
                ],
              )
            : BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
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
                      icon: Stack(children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.shopping_cart),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Obx(() => Padding(
                                  padding: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? roleuser.user.value!.role == 1
                                          ? EdgeInsets.fromLTRB(0, 0, 25, 20)
                                          : EdgeInsets.fromLTRB(0, 0, 45, 20)
                                      : roleuser.user.value!.role == 1
                                          ? EdgeInsets.fromLTRB(0, 0, 65, 0)
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
                      ]),
                      label: 'Cart',
                      backgroundColor: Colors.red),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Cá Nhân'),
                ],
              ));
  }
}
