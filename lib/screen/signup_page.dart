import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/Respositories/signup_management.dart';
import 'package:nieak_project/model/user_model.dart';
import 'package:nieak_project/model_view/hide_modelview.dart';

import '../Respositories/user_database.dart';

class SignupPage extends StatefulWidget {
  final User? user;
  const SignupPage({Key? key, this.user}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernamecontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _repeatcontroller = TextEditingController();
  final _namecontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final checksignup = Get.put(SignupManagement());
  final checkHide = Get.put(HideModelView());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/Sign Up-logo.png",height: 200,width: 200,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Tên Đăng Nhập",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(width: 1, color: Colors.cyanAccent)),
                      errorText: checksignup.textuser == 1
                          ? "Tên Đăng Nhập Không Được Để Trống Và Độ Dài Không Nhỏ Hơn 8!"
                          : null),
                  controller: _usernamecontroller,
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText:  checkHide.hidesignup.value == 1?false:true,
                      decoration: InputDecoration(
                          labelText: "Mật Khẩu",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              BorderSide(width: 1, color: Colors.cyanAccent)),
                          errorText: checksignup.textpass == 1
                              ? "Mật Khẩu Không Được Để Trống Và Độ Dài Không Nhỏ Hơn 8!"
                              : null),
                      controller: _passwordcontroller,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 25, 20, 0),
                      child: GestureDetector(
                        onTap: () {
                          checkHide.updateinsignup();
                        },
                        child: Icon(checkHide.hidesignup.value == 1
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText:  checkHide.hidesignup.value == 1?false:true,
                  decoration: InputDecoration(
                    labelText: "Mật Khẩu Lặp Lại",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(width: 1, color: Colors.cyanAccent)),
                      errorText: checksignup.textrepeat == 1
                          ? "Hãy Nhập Mật Khẩu Lặp Lại!"
                          : null),
                  controller: _repeatcontroller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Họ Và Tên",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(width: 1, color: Colors.cyanAccent)),
                      errorText: checksignup.textname == 1
                          ? "Tên Không Được Để Trống!"
                          : null),
                  controller: _namecontroller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Số Điện Thoại",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(width: 1, color: Colors.cyanAccent)),
                      errorText: checksignup.textname == 1
                          ? "Điện Thoại Không Được Để Trống!"
                          : null),
                  controller: _phonecontroller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(

                  decoration: InputDecoration(
                    labelText: "Địa Chỉ",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(width: 1, color: Colors.cyanAccent)),
                      errorText: checksignup.textname == 1
                          ? "Địa Chỉ Không Được Để Trống!"
                          : null),
                  controller: _addresscontroller,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    checksignup.checkChange(
                        _usernamecontroller.text,
                        _passwordcontroller.text,
                        _repeatcontroller.text,
                        _namecontroller.text,
                        _phonecontroller.text,
                        _addresscontroller.text);
                    checksignup.checkallnull == 1
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Hãy Nhập Đầy Đủ Thông Tin')))
                        : checksignup.checkrepeat == 1
                            ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Mật Khẩu Và Mật Khẩu Nhập Lại Không Chính Xác!')))
                            : checksignup.textuser == 1
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Hãy Nhập Đúng Định Dạng')))
                                : checksignup.textpass == 1
                                    ? ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Hãy Nhập Đúng Định Dạng')))
                                    : checksignup.checkexist == 0
                                        ? {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Đăng Ký Thành Công!'))),
                                            Navigator.pop(context)
                                          }
                                        : ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Tên Đăng Nhập Đã Tồn Tại!')));
                  },
                  child: Text("ĐĂNG NHẬP")),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
