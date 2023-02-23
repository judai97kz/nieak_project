import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/model/cart_model.dart';
import 'package:nieak_project/model_view/add_product_to_cart.dart';

import '../model_view/image_modelview.dart';

class ProductWidget extends StatefulWidget {
  final CartModel? model;
  const ProductWidget({super.key, required this.model});
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final getimage = Get.put(ImageModelView());
  Image convertImg(int i){
    final Uint8List imageData = getimage.images[i].data;
    final Image image = Image.memory(imageData);
    return image;
  }
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  final updateCart = Get.put(AddProductHelper());
  @override
  Widget build(BuildContext context) {
    String editid = widget.model!.idproduct
        .substring(0, widget.model!.idproduct.length - 2);
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
                      for(int i=0;i<getimage.images.length;i++) if(getimage.images[i].id=='$editid-1') Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          width: 80,height: 80,
                          child: convertImg(i)),

                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SizedBox(
                                width: 150,
                                child: Text(
                                  "Size: ${widget.model?.sizeproduct}",
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SizedBox(
                                width: 150,
                                child: Text(
                                    "Đơn Giá:  ${myFormat.format(widget.model!.priceproduct)}"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: SizedBox(
                                  width: 150,
                                  child: Row(
                                    children: [
                                      const Text("Số Lượng: "),
                                      GestureDetector(
                                        onTap: widget.model!.amoutproduct == 1
                                            ? null
                                            : () {
                                                setState(() {
                                                  CartModel model = CartModel(
                                                      idproduct: widget
                                                          .model!.idproduct,
                                                      nameproduct: widget
                                                          .model!.nameproduct,
                                                      priceproduct: widget
                                                          .model!.priceproduct,
                                                      amoutproduct: widget
                                                              .model!
                                                              .amoutproduct -
                                                          1,
                                                      sizeproduct: widget
                                                          .model!.sizeproduct,
                                                      brand:
                                                          widget.model!.brand);
                                                  updateCart
                                                      .updateProduct(model);
                                                });
                                              },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.black),
                                              color: Colors.blue),
                                          height: 20,
                                          width: 20,
                                          child: const Center(child: Text("-")),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        child: Center(
                                            child: Text(
                                                "${widget.model!.amoutproduct}")),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            CartModel model = CartModel(
                                                idproduct:
                                                    widget.model!.idproduct,
                                                nameproduct:
                                                    widget.model!.nameproduct,
                                                priceproduct:
                                                    widget.model!.priceproduct,
                                                amoutproduct:
                                                    widget.model!.amoutproduct +
                                                        1,
                                                sizeproduct:
                                                    widget.model!.sizeproduct,
                                                brand: widget.model!.brand);
                                            updateCart.updateProduct(model);
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.black),
                                              color: Colors.blue),
                                          height: 20,
                                          width: 20,
                                          child: const Center(child: Text("+")),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          AlertDialog alert = AlertDialog(
                            title: const Text("Thông báo"),
                            content: const Text(
                                "Bạn có muốn xóa sản phẩm này ra khỏi giỏ hàng?"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    final deletemodel =
                                        Get.put(AddProductHelper());
                                    deletemodel.deleteProduct(widget.model!);
                                    Navigator.of(context).pop();
                                    deletemodel.keychange();
                                    deletemodel.allprice.value = 0;
                                    deletemodel.fetchAll();
                                  },
                                  child: const Text("Đồng Ý")),
                              const SizedBox(),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Hủy"))
                            ],
                          );

                          showDialog(
                              context: context, builder: (context) => alert);
                        },
                        child: const Icon(Icons.remove_shopping_cart)),
                  )
                ],
              )),
        ]),
      ),
    );
  }
}
