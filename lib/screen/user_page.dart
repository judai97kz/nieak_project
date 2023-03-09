import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Respositories/user_database.dart';
import '../model/user_model.dart';
import '../model_view/hide_modelview.dart';
import '../model_view/home_modelview.dart';
import '../model_view/key_cart_user.dart';
import 'login_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final user = Get.put(Userid());
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();

  // ignore: non_constant_identifier_names
  Widget InfoCustom(String text, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
        child: Stack(
          children: [
            Text(text),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: const Text("Xác Nhận"),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Text("Nhập Thông Tin Muốn Sửa"),
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
                                title: const Text("Xác Nhận"),
                                content: Obx(
                                  () => SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const Text("Nhập Mật Khẩu Để Xác Nhận"),
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
                                                padding:
                                                    const EdgeInsets.fromLTRB(
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
                                              role: user.user.value!.role,
                                              idcart: user.user.value!.idcart,
                                              wallet: user.user.value!.wallet);
                                          UserDatabaseHelper.updateUser(upuser);
                                          user.user.value = upuser;
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text("Xác Nhận")),
                                  const SizedBox(),
                                  ElevatedButton(
                                      onPressed: () {
                                        checkHide.hideinfo.value = 0;
                                        _name.text = "";
                                        _address.text = "";
                                        _phone.text = "";
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Hủy"))
                                ],
                              );

                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => alert);
                            },
                            child: const Text("Xác Nhận")),
                        const SizedBox(),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Hủy"))
                      ],
                    );

                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => alert);
                  },
                  child: const Icon(Icons.edit),
                ))
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
            backgroundColor: Colors.white,
            actions: [
              GestureDetector(
                onTap: () {
                  AlertDialog dialog = AlertDialog(
                    title: Text("Thông Báo"),
                    content: Text("Bạn có muốn đăng xuất khỏi ứng dụng?"),
                    actions: [
                      ElevatedButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.remove('username');
                            await prefs.remove('password');
                            final homemana = Get.put(HomeModel());
                            homemana.currentindex.value = 0;
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                    (Route<dynamic> route) => false);
                          },
                          child: Text("Xác nhận")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text("Hủy"))
                    ],
                  );
                  showDialog(context: context, builder: (context) => dialog);
                },
                child: const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Icon(Icons.logout,color: Colors.black,),
                ),
              ),
            ],
          ),
          body: Obx(() => Column(
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
                          title: const Text("Xác Nhận"),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                const Text("Nhập Mật Khẩu Cũ"),
                                TextField(
                                  controller: textaccept,
                                ),
                                const Text("Nhập Mật Khẩu Mới"),
                                TextField(
                                  controller: newpass,
                                ),
                                const Text("Nhập Lại Mật Khẩu Mới"),
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
                                            role: user.user.value!.role,
                                            idcart: user.user.value!.idcart,
                                            wallet: user.user.value!.wallet);
                                        UserDatabaseHelper.updateUser(upuser);
                                        user.user.value = upuser;
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Thay Đổi Mật Khẩu Thành Công!')));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Mật Khẩu Lặp Lại Khác Nhau')));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Mật Khẩu Mới Phải Lớn Hơn 8')));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Mật Khẩu Sai')));
                                  }
                                },
                                child: const Text("Xác Nhận")),
                            const SizedBox(),
                            ElevatedButton(
                                onPressed: () {
                                  _name.text = "";
                                  _address.text = "";
                                  _phone.text = "";
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Hủy"))
                          ],
                        );

                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => alert);
                      },
                      child: const Text("Đổi Mật Khẩu"))
                ],
              )),
        ));
  }
}
