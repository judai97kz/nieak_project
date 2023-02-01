import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/Respositories/user_database.dart';
import 'package:nieak_project/model/user_model.dart';
import 'package:nieak_project/model_view/hide_modelview.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final user = Get.put(Userid());
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();
  Widget InfoCustom(String text, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide())),
        child: Stack(
          children: [
            Container(
              child: Text(text),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Text("Xác Nhận"),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text("Nhập Thông Tin Muốn Sửa"),
                            TextField(
                              controller: controller,
                            )
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              final textaccept = TextEditingController();
                              final checkHide = Get.put(HideModelView());
                              AlertDialog alert = AlertDialog(
                                title: Text("Xác Nhận"),
                                content: Obx(
                                  () => SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text("Nhập Mật Khẩu Để Xác Nhận"),
                                        Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                obscureText:
                                                    checkHide.hideinfo.value ==
                                                            1
                                                        ? false
                                                        : true,
                                                controller: textaccept,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 18, 10, 0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    checkHide.updateinuser();
                                                  },
                                                  child: Icon(checkHide
                                                              .hideinfo.value ==
                                                          1
                                                      ? Icons.remove_red_eye
                                                      : Icons
                                                          .remove_red_eye_outlined),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        if (textaccept.text ==
                                            user.user.value!.password) {
                                          User upuser = User(
                                              username:
                                                  user.user.value!.username,
                                              password:
                                                  user.user.value!.password,
                                              name: _name.text == ""
                                                  ? user.user.value!.name
                                                  : _name.text,
                                              phone: _phone.text == ""
                                                  ? user.user.value!.phone
                                                  : _phone.text,
                                              address: _address.text == ""
                                                  ? user.user.value!.address
                                                  : _address.text,
                                              idcart: user.user.value!.idcart);
                                          UserDatabaseHelper.updateUser(upuser);
                                          user.user.value = upuser;
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Text("Xác Nhận")),
                                  SizedBox(),
                                  ElevatedButton(
                                      onPressed: () {
                                        checkHide.hideinfo.value = 0;
                                        _name.text = "";
                                        _address.text = "";
                                        _phone.text = "";
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Hủy"))
                                ],
                              );

                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => alert);
                            },
                            child: Text("Xác Nhận")),
                        SizedBox(),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Hủy"))
                      ],
                    );

                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => alert);
                  },
                  child: Icon(Icons.edit),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() => Container(
            child: Column(
              children: [
                InfoCustom("Họ Tên : ${user.user.value!.name}", _name),
                InfoCustom("Địa Chỉ : ${user.user.value!.address}", _address),
                InfoCustom("Điện Thoại : ${user.user.value!.phone}", _phone),
                ElevatedButton(
                    onPressed: () {
                      final textaccept = TextEditingController();
                      final newpass = TextEditingController();
                      final passrepeat = TextEditingController();
                      AlertDialog alert = AlertDialog(
                        title: Text("Xác Nhận"),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text("Nhập Mật Khẩu Cũ"),
                              TextField(
                                controller: textaccept,
                              ),
                              Text("Nhập Mật Khẩu Mới"),
                              TextField(
                                controller: newpass,
                              ),
                              Text("Nhập Lại Mật Khẩu Mới"),
                              TextField(
                                controller: passrepeat,
                              )
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                if (textaccept.text ==
                                    user.user.value!.password) {
                                  if (newpass.text.length > 8) {
                                    if (newpass.text == passrepeat.text) {
                                      User upuser = User(
                                          username: user.user.value!.username,
                                          password: newpass.text,
                                          name: user.user.value!.name,
                                          phone: user.user.value!.phone,
                                          address: user.user.value!.address,
                                          idcart: user.user.value!.idcart);
                                      UserDatabaseHelper.updateUser(upuser);
                                      user.user.value = upuser;
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Thay Đổi Mật Khẩu Thành Công!')));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Mật Khẩu Lặp Lại Khác Nhau')));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Mật Khẩu Mới Phải Lớn Hơn 8')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Mật Khẩu Sai')));
                                }
                              },
                              child: Text("Xác Nhận")),
                          SizedBox(),
                          ElevatedButton(
                              onPressed: () {
                                _name.text = "";
                                _address.text = "";
                                _phone.text = "";
                                Navigator.of(context).pop();
                              },
                              child: Text("Hủy"))
                        ],
                      );

                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => alert);
                    },
                    child: Text("Đổi Mật Khẩu"))
              ],
            ),
          )),
    );
  }
}
