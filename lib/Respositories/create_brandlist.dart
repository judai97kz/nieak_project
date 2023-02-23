import 'package:get/get.dart';
import 'package:nieak_project/Respositories/brand_database.dart';
import 'package:nieak_project/model/brand_model.dart';
import 'package:nieak_project/model_view/brand_modelview.dart';

class CreatBrandList{
  final brandmana = Get.put(BrandModelView());
  final List<String> entries = <String>['All','Nike', 'Puma', 'Adidas', 'Dior'];

  create(){
    for(int i=0;i<entries.length;i++){
      BrandModel newbrand = BrandModel(id: entries[i]);
      brandmana.addBrand(newbrand);
    }
  }
}