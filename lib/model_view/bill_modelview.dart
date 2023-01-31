import 'package:get/get.dart';
import 'package:nieak_project/Respositories/bill_database.dart';
import 'package:nieak_project/model/bill_model.dart';

class BillDatabaseHelper extends GetxController {
  var list = <BillModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  fetchAll() async {
    var bill = await BillDatabase.getAllBill();
    list.value = bill!;
  }

  addBill(BillModel value) {
    BillDatabase.addBill(value);
    fetchAll();
  }

  deleteBill(BillModel value) {
    BillDatabase.deleteBill(value);
    fetchAll();
  }
}
