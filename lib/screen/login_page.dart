import 'package:flutter/material.dart';
import 'package:nieak_project/screen/home_page.dart';
import 'package:nieak_project/screen/signup_page.dart';

import '../model/user_model.dart';
import '../services/user_database.dart';

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
        body: FutureBuilder<List<User>?>(
      future: UserDatabaseHelper.getAllUser(),
      builder: (context, AsyncSnapshot<List<User>?> snapshot) {
        return Column(
          children: [
            TextField(
              controller: _usernamecontroller,
            ),
            TextField(
              controller: _passwordcontroller,
            ),
            ElevatedButton(onPressed: () {
              for(int i=0;i<snapshot.data!.length;i++){
                if(snapshot.data![i].username == _usernamecontroller.text
                    && snapshot.data![i].password == _passwordcontroller.text){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
              }
            }, child: Text("ĐĂNG NHẬP")),
            Row(
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
        );
      },
    ));
  }
}
