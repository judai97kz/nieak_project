import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/model/cart_model.dart';
import 'package:nieak_project/model/shoes_model.dart';
import 'package:nieak_project/model_view/add_cart.dart';
import 'package:nieak_project/model_view/add_product_to_cart.dart';
import 'package:nieak_project/screen/cart_screen.dart';

class InfoPage extends StatefulWidget {
  final Shoes shoes;
  const InfoPage({Key? key, required this.shoes}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final cartadd = Get.put(AddProductInCart());
  final addpro = Get.put(AddProductHelper());
  @override
  Widget build(BuildContext context) {
    int _size = widget.shoes.minsize;
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
                onPressed: () {
                  addpro.keychange();
                  addpro.fetchAll();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyCart(),
                      ));
                },
                child: Icon(Icons.shopping_cart))
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Stack(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: true),
                              items: [
                                for (int i = 1;
                                    i <= widget.shoes.imagenumber;
                                    i++)
                                  Image.asset(
                                    "assets/${widget.shoes.brand}/${widget.shoes.idshoes}/${i}.jpg",
                                    height: 500,
                                    width: 500,
                                  )
                              ],
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.shoes.nameshoes,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(widget.shoes.price,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      )),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            cartadd.size.value = widget.shoes.minsize;
                            cartadd.amout.value = 1;
                            showModalBottomSheet(
                                context: context,
                                builder: (builder) {
                                  return Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    "Size:${cartadd.size}")),
                                          ),
                                          Container(
                                            height: 40,
                                            width: double.infinity,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount:
                                                    widget.shoes.maxsize -
                                                        widget.shoes.minsize,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        _size = index +
                                                            widget
                                                                .shoes.minsize;
                                                        cartadd
                                                            .selectSize(_size);
                                                      },
                                                      child: Text(
                                                        "${index + widget.shoes.minsize}",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      style: ButtonStyle(
                                                          backgroundColor: index ==
                                                                  cartadd.size
                                                                          .value -
                                                                      widget
                                                                          .shoes
                                                                          .minsize
                                                              ? MaterialStatePropertyAll<
                                                                      Color>(
                                                                  Colors.blue)
                                                              : MaterialStatePropertyAll<
                                                                      Color>(
                                                                  Colors
                                                                      .white)),
                                                    ),
                                                  );
                                                }),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("Số lượng")),
                                          ),
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    cartadd.disAmout();
                                                  },
                                                  child: Text("-")),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1.5),
                                                child: Container(
                                                  width: 50,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  child: Center(
                                                    child: Text(
                                                      cartadd.amout.toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    cartadd.addAmout();
                                                  },
                                                  child: Text("+"))
                                            ],
                                          ),
                                          Align(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                CartModel model = CartModel(
                                                    idproduct:
                                                        widget.shoes.idshoes,
                                                    nameproduct:
                                                        widget.shoes.nameshoes,
                                                    priceproduct:
                                                        widget.shoes.price,
                                                    amoutproduct:
                                                        cartadd.amout.value,
                                                    sizeproduct:
                                                        cartadd.size.value,
                                                    brand: widget.shoes.brand);
                                                addpro.addShoes(model);
                                              },
                                              child: Text("Thêm"),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Icon(Icons.add_shopping_cart)),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
