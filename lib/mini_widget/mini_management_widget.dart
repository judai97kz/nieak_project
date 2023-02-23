import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/model_view/add_product_to_cart.dart';
import 'package:nieak_project/screen/editproduct_screen.dart';

import '../model/shoes_model.dart';
import '../model_view/image_modelview.dart';
import '../model_view/shoes_modelview.dart';

class ManagementProductWidget extends StatefulWidget {
  final Shoes model;
  const ManagementProductWidget({super.key, required this.model});
  @override
  State<ManagementProductWidget> createState() =>
      _ManagementProductWidgetState();
}

class _ManagementProductWidgetState extends State<ManagementProductWidget> {
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  final updateCart = Get.put(AddProductHelper());
  final getimage = Get.put(ImageModelView());
  final shoesView = Get.put(ShoesModelView());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
        child: Column(
          children: [
            Text("Tên Sản Phẩm:  ${widget.model.nameshoes}"),
            Text("Size: ${widget.model.minsize}-${widget.model.maxsize}"),
            Text("Lượng Hàng: ${widget.model.amout}"),
            Text("Đơn Giá: ${widget.model.price}"),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>EditProductPage(model: widget.model)));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Center(child: Text("Sửa"))),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        AlertDialog dialog = AlertDialog(
                          content: Text("Xóa Sản Phẩm?"),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  shoesView.deleteShoes(widget.model);
                                  for (int i = 0;
                                      i < widget.model.imagenumber;
                                      i++) {
                                    getimage.deleteimage(
                                        "${widget.model.idshoes}-${i + 1}");
                                  }
                                  Navigator.of(context).pop(true);
                                },
                                child: Text("Xác Nhận")),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text("Hủy"))
                          ],
                        );
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => dialog);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Center(child: Text("Xóa"))),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
