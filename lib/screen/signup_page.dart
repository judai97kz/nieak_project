import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/Respositories/signup_management.dart';
import 'package:nieak_project/model/user_model.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  errorText: checksignup.textuser == 1
                      ? "Tên Đăng Nhập Không Được Để Trống Và Độ Dài Không Nhỏ Hơn 8!"
                      : null),
              controller: _usernamecontroller,
            ),
            TextField(
              controller: _passwordcontroller,
            ),
            TextField(
              controller: _repeatcontroller,
            ),
            TextField(
              controller: _namecontroller,
            ),
            TextField(
              controller: _phonecontroller,
            ),
            TextField(
              controller: _addresscontroller,
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
                                      ? {ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(
                  content: Text(
                  'Đăng Ký Thành Công!'))),
                    Navigator.pop(context)}
                                      : ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Tên Đăng Nhập Đã Tồn Tại!')));
                },
                child: Text("ĐĂNG NHẬP")),
          ],
        ),
      ),
    );
  }
}
