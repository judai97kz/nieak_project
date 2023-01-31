import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import 'package:nieak_project/screen/home_page.dart';

class CMScreen extends StatelessWidget {
  const CMScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keycart = Get.put(Userid());
    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              Image.asset("assets/logomini.png"),
              Text(
                "Đơn Hàng Của Bạn Đã Được Xác Nhận Và Sẽ Được Gửi Tới Bạn Sau Vài Ngày!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                keycart: 'id${keycart.idcart}',
                              )),
                      (Route<dynamic> route) => false);
                },
                child: Text("Nhấn đây để trở về trang chủ"),
              )
            ],
          )),
        ),
      ),
    );
  }
}
