import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/Respositories/login_management.dart';
import 'package:nieak_project/model_view/hide_modelview.dart';
import 'package:nieak_project/screen/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernamecontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final getlogin = Get.put(LoginManagement());
  final checkHide = Get.put(HideModelView());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? "assets/no.jfif"
                        : "assets/no1.jfif"))),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(color: Colors.white, width: 10)),
                            child: Image.asset("assets/logolight.png")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: TextStyle(
                              color: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? Colors.white
                                  : Colors.black),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              labelText: "Tên Đăng Nhập",
                              labelStyle: TextStyle(
                                  color: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? Colors.white
                                      : Colors.grey),

                              errorText: getlogin.textuser.value == 1
                                  ? "Tên Đăng Nhập Không Được Để Trống Và Độ Dài Không Nhỏ Hơn 8!"
                                  : null),
                          controller: _usernamecontroller,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            TextField(
                              style: TextStyle(
                                  color: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? Colors.white
                                      : Colors.black),
                              onSubmitted: (passwordcontroller) {
                                getlogin.checkChange(_usernamecontroller.text,
                                    passwordcontroller, context);
                              },
                              textInputAction: TextInputAction.done,
                              obscureText:
                                  // ignore: unrelated_type_equality_checks
                                  checkHide.hidelogin == 1 ? false : true,
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color:
                                          MediaQuery.of(context).orientation ==
                                                  Orientation.portrait
                                              ? Colors.white
                                              : Colors.grey),

                                  labelText: "Mật Khẩu",
                                  errorText: getlogin.textpass.value == 1
                                      ? "Mật Khẩu Không Được Để Trống Và Độ Dài Không Nhỏ Hơn 8!"
                                      : null),
                              controller: _passwordcontroller,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 18, 10, 0),
                                child: GestureDetector(
                                  onTap: () {
                                    checkHide.updateinlogin();
                                  },
                                  // ignore: unrelated_type_equality_checks
                                  child: Icon(
                                    // ignore: unrelated_type_equality_checks
                                    checkHide.hidelogin == 1
                                        ? Icons.remove_red_eye
                                        : Icons.remove_red_eye_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              getlogin.checkChange(_usernamecontroller.text,
                                  _passwordcontroller.text, context);
                            },
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  // ignore: prefer_const_literals_to_create_immutables
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  border: Border.all(color: Colors.black)),
                              child: const Center(
                                  child: Text(
                                "Đăng Nhập",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(242, 10, 14, 240)),
                              )),
                            )),
                      ),
                      const SizedBox(
                        height: 70,
                        child: Center(
                          child: Text(
                            "Hoặc",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupPage()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Chưa có tài khoản?"),
                            GestureDetector(
                              child: const Text(
                                "Đăng ký ngay!",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
