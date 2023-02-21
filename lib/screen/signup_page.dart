import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/Respositories/signup_management.dart';
import 'package:nieak_project/model/user_model.dart';
import 'package:nieak_project/model_view/hide_modelview.dart';



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

  // ignore: non_constant_identifier_names
  void SignUpAction(){
    checksignup.checkChange(
        _usernamecontroller.text,
        _passwordcontroller.text,
        _repeatcontroller.text,
        _namecontroller.text,
        _phonecontroller.text,
        _addresscontroller.text);
    // ignore: unrelated_type_equality_checks
    checksignup.checkallnull == 1
        ? ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hãy Nhập Đầy Đủ Thông Tin')))
        // ignore: unrelated_type_equality_checks
        : checksignup.checkrepeat == 1
        // ignore: prefer_const_constructors
        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
            'Mật Khẩu Và Mật Khẩu Nhập Lại Không Chính Xác!')))
        // ignore: unrelated_type_equality_checks
        : checksignup.textuser == 1
        ? ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Hãy Nhập Đúng Định Dạng')))
        // ignore: unrelated_type_equality_checks
        : checksignup.textpass == 1
        ? ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
            Text('Hãy Nhập Đúng Định Dạng')))
        // ignore: unrelated_type_equality_checks
        : checksignup.checkexist == 0
        ? {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
          content: Text(
              'Đăng Ký Thành Công!'))),
      Navigator.pop(context)
    }
        : ScaffoldMessenger.of(context)
        // ignore: prefer_const_constructors
        .showSnackBar(SnackBar(
        content: const Text(
            'Tên Đăng Nhập Đã Tồn Tại!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
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
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: "Tên Đăng Nhập",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.cyanAccent)),
                      // ignore: unrelated_type_equality_checks
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
                      textInputAction: TextInputAction.next,
                      obscureText:  checkHide.hidesignup.value == 1?false:true,
                      decoration: InputDecoration(
                          labelText: "Mật Khẩu",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              const BorderSide(width: 1, color: Colors.cyanAccent)),
                          // ignore: unrelated_type_equality_checks
                          errorText: checksignup.textpass == 1
                              ? "Mật Khẩu Không Được Để Trống Và Độ Dài Không Nhỏ Hơn 8!"
                              : null),
                      controller: _passwordcontroller,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 25, 20, 0),
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
                  textInputAction: TextInputAction.next,
                  obscureText:  checkHide.hidesignup.value == 1?false:true,
                  decoration: InputDecoration(
                    labelText: "Mật Khẩu Lặp Lại",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.cyanAccent)),
                      // ignore: unrelated_type_equality_checks
                      errorText: checksignup.textrepeat == 1
                          ? "Hãy Nhập Mật Khẩu Lặp Lại!"
                          : null),
                  controller: _repeatcontroller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Họ Và Tên",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.cyanAccent)),
                      // ignore: unrelated_type_equality_checks
                      errorText: checksignup.textname == 1
                          ? "Tên Không Được Để Trống!"
                          : null),
                  controller: _namecontroller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Số Điện Thoại",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.cyanAccent)),
                      // ignore: unrelated_type_equality_checks
                      errorText: checksignup.textname == 1
                          ? "Điện Thoại Không Được Để Trống!"
                          : null),
                  controller: _phonecontroller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onSubmitted: (text){SignUpAction();},
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Địa Chỉ",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.cyanAccent)),
                      // ignore: unrelated_type_equality_checks
                      errorText: checksignup.textname == 1
                          ? "Địa Chỉ Không Được Để Trống!"
                          : null),
                  controller: _addresscontroller,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                   SignUpAction();
                  },
                  child: const Text("ĐĂNG KÝ")),
              // ignore: prefer_const_constructors
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

