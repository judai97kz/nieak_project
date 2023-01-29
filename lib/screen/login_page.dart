import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/screen/signup_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextField(
            controller: _usernamecontroller,
          ),
          TextField(
            controller: _passwordcontroller,
          ),
          ElevatedButton(
              onPressed: () {
                UserDatabaseHelper.getAllUser(_usernamecontroller.text,
                    _passwordcontroller.text, context);
              },
              child: Text("ĐĂNG NHẬP")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Chưa có tài khoản?"),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: Text("Đăng ký ngay!"),
              )
            ],
          )
        ],
      ),
    );
  }
}
