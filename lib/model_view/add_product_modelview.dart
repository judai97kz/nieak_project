import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nieak_project/model_view/shoes_modelview.dart';
import '../model/shoes_model.dart';

class AddProductModelView extends GetxController {
  var textid = "".obs;
  var textname = "".obs;
  var textprice = "".obs;
  var textamout = "".obs;
  var textmin = "".obs;
  var textmax = "".obs;
  var textcolor = "".obs;


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
      BuildContext context) async {
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
      if(int.parse(min)<=int.parse(max)){
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
          rating: 0.0
        );
        final addnewshoes = Get.put(ShoesModelView());
        addnewshoes.checkShoes(newShoes, imageFileList, context);
      }else{
        textmin.value = "Kích thước tối thiểu phải nhỏ hơn kích thước tối đa!";
        textmax.value = "Kích thước tối đa phải nhỏ hơn kích thước tối thiểu!";
      }
    }
  }
}
