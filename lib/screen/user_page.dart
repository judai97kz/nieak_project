import 'package:flutter/material.dart';
import 'package:nieak_project/screen/bill_screen.dart';
import 'package:nieak_project/screen/infoapp_page.dart';
import 'package:nieak_project/screen/login_page.dart';
import 'package:nieak_project/screen/userinfo_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // ignore: non_constant_identifier_names
  Widget ButtonAreaEdit(String title, Icon icon, Color colortext) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black),color: Colors.white),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(color: colortext),
              ),
            ),
            Align(alignment: Alignment.centerRight, child: icon)
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
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const UserInfoPage()));
                },
                child: ButtonAreaEdit(
                    "Thông Tin Cá Nhân", const Icon(Icons.person), Colors.cyanAccent),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyBill()));
                },
                child: ButtonAreaEdit("Lịch Sử Mua Hàng",
                    const Icon(Icons.shopping_basket), Colors.red),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const InfoAppPage()));
                },
                child: ButtonAreaEdit(
                    "Thông Tin Liên Hệ", const Icon(Icons.call), Colors.green),
              ),
              ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('username');
                    await prefs.remove('password');
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                  child: const Text("Log out"))
            ]),
          ),
        ));
  }
}
