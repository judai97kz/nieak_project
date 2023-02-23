import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/screen/bill_screen.dart';
import 'package:nieak_project/screen/infoapp_page.dart';
import 'package:nieak_project/screen/login_page.dart';
import 'package:nieak_project/screen/userinfo_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model_view/home_modelview.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // ignore: non_constant_identifier_names
  Widget ButtonAreaEdit(String title, Icon icon, Color colortext) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black), color: Colors.white),
      height: 100,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(color: colortext),
              ),
            ),
            Container(alignment: Alignment.centerRight, child: icon)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(image: AssetImage("assets/lobg.jpg"))),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Cài Đặt"),
            actions: [
              GestureDetector(
                onTap: () {
                  AlertDialog dialog = AlertDialog(
                    title: Text("Thông Báo"),
                    content: Text("Bạn có muốn đăng xuất khỏi ứng dụng?"),
                    actions: [
                      ElevatedButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.remove('username');
                            await prefs.remove('password');
                            final homemana = Get.put(HomeModel());
                            homemana.currentindex.value = 0;
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (Route<dynamic> route) => false);
                          },
                          child: Text("Xác nhận")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text("Hủy"))
                    ],
                  );
                  showDialog(context: context, builder: (context) => dialog);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.logout),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserInfoPage()));
                },
                child: ButtonAreaEdit("Thông Tin Cá Nhân",
                    const Icon(Icons.person), Colors.deepOrange),
              ),
              Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyBill()));
                },
                child: ButtonAreaEdit("Lịch Sử Mua Hàng",
                    const Icon(Icons.shopping_basket), Colors.red),
              ),
              Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InfoAppPage()));
                },
                child: ButtonAreaEdit(
                    "Thông Tin Liên Hệ", const Icon(Icons.call), Colors.green),
              ),
            ]),
          ),
        ));
  }
}
