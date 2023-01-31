import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/model/cart_model.dart';
import 'package:nieak_project/model/shoes_model.dart';
import 'package:nieak_project/model_view/add_cart.dart';
import 'package:nieak_project/model_view/add_product_to_cart.dart';
import 'package:nieak_project/screen/cart_screen.dart';
import 'package:nieak_project/screen/user_page.dart';

class InfoPage extends StatefulWidget {
  final Shoes shoes;
  const InfoPage({Key? key, required this.shoes}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final cartadd = Get.put(AddProductInCart());
  final addpro = Get.put(AddProductHelper());
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  @override
  Widget build(BuildContext context) {
    int _size = widget.shoes.minsize;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Thông Tin Sản Phẩm"),
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
                child: const Icon(Icons.shopping_cart)),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserPage()));
                },
                child: const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/Nike/Nike1/1.jpg",
                    ),
                  ),
                ))
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
                            color: Colors.cyan,
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
                                  Stack(
                                    children: [
                                      Image.asset(
                                        "assets/${widget.shoes.brand}/${widget.shoes.idshoes}/${i}.jpg",
                                        height: 500,
                                        width: 500,
                                      ),
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            color: Colors.white10,
                                            child: Text(
                                                "${i}/${widget.shoes.imagenumber}"),
                                          ))
                                    ],
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Giá: ${myFormat.format(widget.shoes.price)}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          )),
                    ),
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                        ),
                      ),
                      Align(
                        child:
                            Container(child: const Text("Thông Tin Sản Phẩm")),
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Thương Hiệu:${widget.shoes.brand}")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Kích Thước Giày : ${widget.shoes.minsize} - ${widget.shoes.maxsize}")),
                  ),
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
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
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
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1.0),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          _size = index +
                                                              widget.shoes
                                                                  .minsize;
                                                          cartadd.selectSize(
                                                              _size);
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
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
                                                            color:
                                                                Colors.black)),
                                                    child: Center(
                                                      child: Text(
                                                        cartadd.amout
                                                            .toString(),
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
                                                          widget.shoes.idshoes +
                                                              cartadd.size.value
                                                                  .toString(),
                                                      nameproduct: widget
                                                          .shoes.nameshoes,
                                                      priceproduct:
                                                          widget.shoes.price,
                                                      amoutproduct:
                                                          cartadd.amout.value,
                                                      sizeproduct:
                                                          cartadd.size.value,
                                                      brand:
                                                          widget.shoes.brand);
                                                  addpro.addShoes(model);
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              'Thêm Sản Phẩm Thành Công!')));
                                                },
                                                child: Text("Thêm"),
                                              ),
                                            )
                                          ],
                                        ),
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
