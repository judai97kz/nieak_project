import 'package:get/get.dart';
import 'package:nieak_project/Respositories/brand_database.dart';

import '../model/brand_model.dart';

class BrandModelView extends GetxController{
  var listbrand = <BrandModel>[].obs;
  var brandState = "Nike".obs;

  getBrand() async {
    var list = await BrandDatabaseHelper.getAllBrand();
    listbrand.value = list!;
  }
  addBrand(BrandModel brand) async{
    await BrandDatabaseHelper.addBrand(brand);
    getBrand();
  }

  deleteBrand(BrandModel brand) async {
    await BrandDatabaseHelper.deleteBrand(brand);
    getBrand();
  }



}