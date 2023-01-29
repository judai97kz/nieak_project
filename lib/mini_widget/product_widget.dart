import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nieak_project/model/cart_model.dart';
import 'package:nieak_project/model_view/add_product_to_cart.dart';

class ProductWidget extends StatefulWidget {
  final CartModel? model;
  const ProductWidget({super.key, required this.model});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15)),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text("${widget.model?.nameproduct}"),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: Colors.cyan)),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Image.asset(
                          "assets/${widget.model?.brand}/${widget.model?.idproduct}/1.jpg",
                          height: 80,
                          width: 80,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          textDirection: TextDirection.ltr,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                "Size: ${widget.model?.sizeproduct}",
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                  "Đơn Giá:  ${widget.model?.priceproduct}"),
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                  "Số Lượng: ${widget.model?.amoutproduct}"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    child: GestureDetector(
                        onTap: () {
                          AlertDialog alert = AlertDialog(
                            title: Text("Thông báo"),
                            content: Text(
                                "Bạn có muốn xóa sản phẩm này ra khỏi giỏ hàng?"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    final deletemodel =
                                        Get.put(AddProductHelper());
                                    deletemodel.deleteProduct(widget.model!);
                                    Navigator.of(context).pop();
                                    deletemodel.keychange();
                                    deletemodel.fetchAll();
                                  },
                                  child: Text("Đồng Ý")),
                              SizedBox(),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Hủy"))
                            ],
                          );
                          print("Hello");
                          showDialog(
                              context: context, builder: (context) => alert);
                        },
                        child: Icon(Icons.remove_shopping_cart)),
                    alignment: Alignment.centerRight,
                  )
                ],
              )),
        ]),
      ),
    );
  }
}
