
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nieak_project/model/bill_model.dart';

Widget miniBill(BillModel bill) {
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  return Container(
    decoration: BoxDecoration(border: Border.all(color: Colors.black87)),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(color: Colors.black87)),
          child: Text("Mã Đơn Mua Hàng: ${bill.idbill}"),
        ),
        Column(
          children: [
            Text("Thời gian tạo : ${bill.billtime}"),
            Text("Sản phẩm:\n${bill.contentbill}"),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
            ),
            Text("Tổng Tiền: ${myFormat.format(bill.pricebill)}")
          ],
        ),
      ],
    ),
  );
}
