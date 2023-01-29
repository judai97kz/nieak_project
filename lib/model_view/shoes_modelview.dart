import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nieak_project/Respositories/shoes_database.dart';
import 'package:nieak_project/model/shoes_model.dart';

class ShoesModelView extends GetxController{

  var allShoes = <Shoes>[].obs;

   @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAll("All");
  }

  fetchAll(String brand) async {
     var shoes = await ShoesDatabaseHelper.getAllShoes(brand);
     allShoes.value = shoes!;
  }

  addShoes(Shoes value){
     ShoesDatabaseHelper.addShoes(value);
     fetchAll("All");
  }


}