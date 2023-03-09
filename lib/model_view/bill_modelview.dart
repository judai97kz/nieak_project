import 'package:get/get.dart';
import 'package:nieak_project/Respositories/bill_database.dart';
import 'package:nieak_project/Respositories/orderbill_database.dart';
import 'package:nieak_project/model/bill_model.dart';

import '../model/orderbill_model.dart';

class BillDatabaseHelper extends GetxController {
  var list = <BillModel>[].obs;
  var listorder = <OrderBillModel>[].obs;
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

  getOrderBill() async {
    var bill = await OrderBillDatabase.getAllBill();
    listorder.value = bill!;
  }
  addOrderBill(OrderBillModel value) async {
    await OrderBillDatabase.addBill(value);
    getOrderBill();
  }
  deleteOrderBill(OrderBillModel value) async {
    await OrderBillDatabase.deleteBill(value);
   getOrderBill();
  }
}
