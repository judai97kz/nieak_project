import 'dart:math';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/Respositories/add_shoes.dart';
import 'package:nieak_project/model/shoes_model.dart';
import 'package:nieak_project/model_view/add_product_to_cart.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import 'package:nieak_project/screen/cart_screen.dart';
import 'package:nieak_project/screen/info_page.dart';
import 'package:nieak_project/model_view/shoes_modelview.dart';
import 'package:nieak_project/screen/user_page.dart';
import '../Respositories/shoes_database.dart';

final List<String> entries = <String>['All', 'Nike', 'Puma', 'Adidas', 'Dior'];
String catelogy = 'All';

class HomePage extends StatefulWidget {
  final String keycart;
  const HomePage({Key? key, required this.keycart}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final shoesView = Get.put(ShoesModelView());
  final idcart = Get.put(Userid());
  final cartView = Get.put(AddProductHelper());
  final AddShoes allShoes = AddShoes();

  final textfind = TextEditingController();
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AnimSearchBar(
            width: MediaQuery.of(context).orientation == Orientation.portrait
                ? 300
                : 600,
            textController: textfind,
            onSuffixTap: () {},
            autoFocus: true,
            onSubmitted: (String) {
              shoesView.findShoes(String);
            },
          ),
          automaticallyImplyLeading: false,
          actions: [
            ElevatedButton(
              onPressed: () {
                cartView.keychange();
                cartView.fetchAll();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyCart(),
                    ));
              },
              child: Stack(
                children: [
                  Align(
                    child: Icon(Icons.shopping_cart),
                    alignment: Alignment.center,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Obx(() => Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 25),
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.red,
                              child: Text(
                                "${cartView.allProduct.length}",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ))),
                ],
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/Nike/Nike1/1.jpg",
                    ),
                  ),
                ))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(image: AssetImage("assets/bg2.jfif"))),
          child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool isScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    title: Image.asset("assets/Nike/Nike1/1.jpg"),
                    toolbarHeight: 200,
                  )
                ];
              },
              body: Padding(
                padding: const EdgeInsets.all(1.5),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        height: 40,
                        width: double.infinity,
                        child: Container(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: entries.length,
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      shoesView.fetchAll(entries[index]);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 60,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.primaries[Random()
                                                .nextInt(
                                                    Colors.primaries.length)]),
                                        child: Center(
                                          child: Text(
                                            entries[index],
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                        )),
                    Obx(
                      () => Expanded(
                          child: GridView.count(
                        childAspectRatio: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? WidgetsBinding.instance.window.physicalSize.height <
                                    1300
                                ? (9 / 10)
                                : (11 / 13)
                            : (10 / 11),
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 3,
                        children: List.generate(
                            shoesView.allShoes.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => InfoPage(
                                                shoes:
                                                    shoesView.allShoes[index])));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Image.asset(
                                              "assets/${shoesView.allShoes[index].brand}/${shoesView.allShoes[index].idshoes}/1.jpg",
                                              height: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 130
                                                  : 150,
                                              width: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 130
                                                  : 150,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 50
                                                  : 40,
                                              child: Text(
                                                shoesView
                                                    .allShoes[index].nameshoes,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 11.5),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15.0, left: 15.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: SizedBox(
                                                height: 20,
                                                child: Text(
                                                    '${myFormat.format(shoesView.allShoes[index].price)} đồng.')),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                      )),
                    )
                  ],
                ),
              )),
        ));
  }
}
