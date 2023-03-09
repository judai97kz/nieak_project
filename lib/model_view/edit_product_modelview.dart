import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nieak_project/model_view/image_modelview.dart';
import 'package:nieak_project/model_view/shoes_modelview.dart';
import '../model/image_model.dart';
import '../model/shoes_model.dart';

class EditProductModelView extends GetxController {
  final imagemodel = Get.put(ImageModelView());

  var textid = "".obs;
  var textname = "".obs;
  var textprice = "".obs;
  var textamout = "".obs;
  var textmin = "".obs;
  var textmax = "".obs;
  var textcolor = "".obs;

  Future<Uint8List> fileToUint8List(File file) async {
    List<int> bytes = await file.readAsBytes();
    return Uint8List.fromList(bytes);
  }

  check(
      String id,
      String name,
      String price,
      String amout,
      String min,
      String max,
      String color,
      String brand,
      List<XFile> imageFileList,
      BuildContext context,
      int Oldimage,double rating,) async {
    if (id == "" ||
        name == "" ||
        price == "" ||
        amout == "" ||
        min == "" ||
        max == "" ||
        color == "") {
      if (id == "") {
        textid.value = "Không được để trống";
      } else {
        textid.value = "";
      }
      if (name == "") {
        textname.value = "Không được để trống";
      } else {
        textname.value = "";
      }
      if (price == "") {
        textprice.value = "Không được để trống";
      } else {
        textprice.value = "";
      }
      if (amout == "") {
        textamout.value = "Không được để trống";
      } else {
        textamout.value = "";
      }
      if (min == "") {
        textmin.value = "Không được để trống";
      } else {
        textmin.value = "";
      }
      if (max == "") {
        textmax.value = "Không được để trống";
      } else {
        textmax.value = "";
      }
      if (color == "") {
        textcolor.value = "Không được để trống";
      } else {
        textcolor.value = "";
      }
    } else {
      if (int.parse(min) <= int.parse(max)) {
        textmin.value = "";
        textmax.value = "";
        Shoes newShoes = Shoes(
            idshoes: id,
            nameshoes: name,
            price: int.parse(price),
            color: color,
            minsize: int.parse(min),
            maxsize: int.parse(max),
            brand: brand,
            imagenumber: imageFileList.length,
            amout: int.parse(amout),
          rating: rating
        );

        for (int i = 0; i < Oldimage; i++) {
          imagemodel.deleteimage("${id}-${i + 1}");
        }
        final addnewshoes = Get.put(ShoesModelView());
        addnewshoes.updateShoes(newShoes);
        for (int i = 0; i < imageFileList.length; i++) {
          File imageFile = File(imageFileList[i].path);
          Uint8List uint8List = await fileToUint8List(imageFile);
          ImageModel newimage =
              ImageModel(id: "${id}-${i + 1}", groupimage: id, data: uint8List);
          imagemodel.addimage(newimage);
          imagemodel.getImage();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Cập Nhật Thông Tin Sản Phẩm Thành Công!')));
        }
      } else {
        textmin.value = "Kích thước tối thiểu phải nhỏ hơn kích thước tối đa!";
        textmax.value = "Kích thước tối đa phải nhỏ hơn kích thước tối thiểu!";
      }
    }
  }
}
