import 'package:get/get.dart';
import 'package:nieak_project/Respositories/shoes_database.dart';
import 'package:nieak_project/model/shoes_model.dart';

class ShoesModelView extends GetxController {
  var allShoes = <Shoes>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAll("All");
  }

  fetchAll(String brand) async {
    var shoes = await ShoesDatabaseHelper.getAllShoes(brand);
    allShoes.value = shoes!;
  }

  addShoes(Shoes value) {
    ShoesDatabaseHelper.addShoes(value);
    fetchAll("All");
  }

  findShoes(String name) async {
    var shoes = await ShoesDatabaseHelper.findShoes(name);
    allShoes.value = shoes!;
  }
}
