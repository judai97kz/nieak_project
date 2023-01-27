import 'package:flutter/material.dart';
import 'package:nieak_project/model/user_model.dart';

import '../services/user_database.dart';

class SignupPage extends StatefulWidget {
  final User? user;
  const SignupPage({Key? key,this.user}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernamecontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _namecontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(controller: _usernamecontroller,),
          TextField(controller: _passwordcontroller,),
          TextField(controller: _namecontroller,),
          TextField(controller: _phonecontroller,),
          TextField(controller: _addresscontroller,),
          ElevatedButton(onPressed: () async {
            User model = User(
              username: _usernamecontroller.text,
              password: _passwordcontroller.text,
              name: _namecontroller.text,
              phone: _phonecontroller.text,
              address: _addresscontroller.text,
              idcart: 'id${_usernamecontroller.text}'
            );
            if(widget.user==null){
              await UserDatabaseHelper.addUser(model);
            }else{
              await UserDatabaseHelper.updateUser(model);
            }
            Navigator.pop(context);
          }, child: Text("ĐĂNG NHẬP")),

        ],
      ),
    );
  }
}
