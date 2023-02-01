import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/Respositories/login_management.dart';
import 'package:nieak_project/model_view/hide_modelview.dart';
import 'package:nieak_project/screen/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Respositories/user_database.dart';
import '../model/user_model.dart';

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

  Widget TextFieldCustom(TextEditingController controller) {
    return TextField(
      controller: controller,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.black)),
                    child: Image.asset("assets/nieaklogo.png")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Tên Đăng Nhập",
                      labelStyle: TextStyle(color: Colors.cyanAccent),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(width: 1, color: Colors.cyanAccent)),
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
                      obscureText: checkHide.hidelogin == 1 ? false : true,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.cyanAccent),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  width: 1, color: Colors.cyanAccent)),
                          labelText: "Mật Khẩu",
                          errorText: getlogin.textpass.value == 1
                              ? "Mật Khẩu Không Được Để Trống Và Độ Dài Không Nhỏ Hơn 8!"
                              : null),
                      controller: _passwordcontroller,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 18, 10, 0),
                        child: GestureDetector(
                          onTap: () {
                            checkHide.updateinlogin();
                          },
                          child: Icon(checkHide.hidelogin == 1
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined),
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
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          border: Border.all(color: Colors.black)),
                      child: Center(
                          child: Text(
                        "Đăng Nhập",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 231, 146, 34)),
                      )),
                    )),
              ),
              Container(
                height: 40,
                child: Center(
                  child: Text("Hoặc"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Chưa có tài khoản?"),
                    GestureDetector(
                      child: Text(
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
    );
  }
}
