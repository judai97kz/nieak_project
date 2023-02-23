import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/model/cart_model.dart';
import 'package:nieak_project/model/shoes_model.dart';
import 'package:nieak_project/model_view/add_cart.dart';
import 'package:nieak_project/model_view/add_product_to_cart.dart';
import 'package:nieak_project/model_view/image_modelview.dart';
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
  final getimage = Get.put(ImageModelView());
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getimage.getImageByGroup(widget.shoes.idshoes);

  }
  Image convertImg(int i){
    final Uint8List imageData = getimage.listimg[i].data;
    final Image image = Image.memory(imageData);
    return image;
  }
  @override
  Widget build(BuildContext context) {
    int size = widget.shoes.minsize;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Thông Tin Sản Phẩm"),
          leading: BackButton(
            onPressed: (){
              getimage.listimg.value=[];
              Navigator.of(context).pop();
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyCart(),
                    ));
              },
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.shopping_cart),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Obx(() => Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 25),
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.red,
                              child: Text(
                                "${addpro.allProduct.length}",
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ))),
                ],
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const UserPage()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
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
                          borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: Colors.black)),
                        child: Stack(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: true),
                              items: [
                                for (int i = 0;
                                    i <  getimage.listimg.length;
                                    i++)
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                          child: Container(child: convertImg(i),)),
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            color: Colors.white10,
                                            child: Text(
                                                "${i+1}/${widget.shoes.imagenumber}"),
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
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.center,
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                              child: const Text(
                            "Thông Tin Sản Phẩm",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                        ),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "Tình Trạng: ${widget.shoes.amout == 0 ? "Hết Hàng" : "Còn ${widget.shoes.amout} đôi"}"),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.shoes.amout == 0
                        ? const ElevatedButton(
                            onPressed: null,
                            child: Text("Không thể đặt hàng!"))
                        : ElevatedButton(
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
                                              SizedBox(
                                                height: 40,
                                                width: double.infinity,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemCount: widget
                                                            .shoes.maxsize +
                                                        1 -
                                                        widget.shoes.minsize,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(1.0),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            size = index +
                                                                widget.shoes
                                                                    .minsize;
                                                            cartadd
                                                                .selectSize(
                                                                    size);
                                                          },
                                                          // ignore: sort_child_properties_last
                                                          child: Text(
                                                            "${index + widget.shoes.minsize}",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          style: ButtonStyle(
                                                              backgroundColor: index ==
                                                                      cartadd.size.value -
                                                                          widget
                                                                              .shoes.minsize
                                                                  ? const MaterialStatePropertyAll<
                                                                          Color>(
                                                                      Colors
                                                                          .blue)
                                                                  : const MaterialStatePropertyAll<
                                                                          Color>(
                                                                      Colors
                                                                          .white)),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.all(8.0),
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
                                                      child: const Text("-")),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.5),
                                                    child: Container(
                                                      width: 50,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black)),
                                                      child: Center(
                                                        child: Text(
                                                          cartadd.amout
                                                              .toString(),
                                                          textAlign: TextAlign
                                                              .center,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        cartadd.addAmout();
                                                      },
                                                      child: const Text("+"))
                                                ],
                                              ),
                                              Align(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    CartModel model = CartModel(
                                                        idproduct: widget
                                                                .shoes
                                                                .idshoes +
                                                            cartadd.size.value
                                                                .toString(),
                                                        nameproduct: widget
                                                            .shoes.nameshoes,
                                                        priceproduct: widget
                                                            .shoes.price,
                                                        amoutproduct: cartadd
                                                            .amout.value,
                                                        sizeproduct: cartadd
                                                            .size.value,
                                                        brand: widget
                                                            .shoes.brand);
                                                    addpro.addShoes(model);
                                                    Navigator.of(context)
                                                        .pop();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(const SnackBar(
                                                            content: Text(
                                                                'Thêm Sản Phẩm Thành Công!')));
                                                  },
                                                  child: const Text("Thêm"),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: const Icon(Icons.add_shopping_cart)),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
