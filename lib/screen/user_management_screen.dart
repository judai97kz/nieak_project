import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/model/user_model.dart';
import 'package:nieak_project/model_view/User_ModelView.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({Key? key}) : super(key: key);
  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final listuser = Get.put(UserModelView());
  final userislogin = Get.put(Userid());
  final manauser = Get.put(UserModelView());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listuser.getUser();
  }

  @override
  Widget build(BuildContext context) {
    print(listuser.listuser.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản Lý Người Dùng"),
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: listuser.listuser.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(9.5),
                          bottomRight: Radius.circular(9.5)),
                    ),
                    child: listuser.listuser[index].role == 1
                        ? SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 150,
                                          child: Text(
                                            "Tên Đăng Nhập:",
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            listuser.listuser[index].username,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: Text("Tên Người Dùng:",
                                              textAlign: TextAlign.start),
                                        ),
                                        Container(
                                          child: Text(
                                              listuser.listuser[index].name),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: Text("Số Điện Thoại:"),
                                        ),
                                        Container(
                                          child: Text(
                                              listuser.listuser[index].phone),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: Text("Địa Chỉ:"),
                                        ),
                                        Container(
                                          child: Text(
                                              listuser.listuser[index].address),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Expanded(
                                  child: GestureDetector(
                                child: Icon(Icons.edit),
                                onTap: () {
                                  final name = TextEditingController(
                                      text: listuser.listuser[index].name);
                                  final phone = TextEditingController(
                                      text: listuser.listuser[index].phone);
                                  final address = TextEditingController(
                                      text: listuser.listuser[index].address);
                                  AlertDialog dialog = AlertDialog(
                                    title: Text("Cảnh Báo!"),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: name,
                                            decoration: InputDecoration(
                                                labelText: "Tên người dùng"),
                                          ),
                                          TextField(
                                            controller: phone,
                                            decoration: InputDecoration(
                                                labelText: "Số điện thoại"),
                                          ),
                                          TextField(
                                            controller: address,
                                            decoration: InputDecoration(
                                                labelText: "Địa chỉ"),
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            final _acceptnewcontroller =
                                                TextEditingController();
                                            AlertDialog dialog = AlertDialog(
                                              title: Text("Xác nhận"),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Text("Nhập mật khẩu"),
                                                    TextField(
                                                      controller:
                                                          _acceptnewcontroller,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      if (_acceptnewcontroller
                                                              .text ==
                                                          userislogin
                                                              .user
                                                              .value!
                                                              .password) {
                                                        User user = User(
                                                            username: listuser
                                                                .listuser[index]
                                                                .username,
                                                            password: listuser
                                                                .listuser[index]
                                                                .password,
                                                            name: name.text,
                                                            phone: phone.text,
                                                            address:
                                                                address.text,
                                                            idcart: listuser
                                                                .listuser[index]
                                                                .idcart,
                                                            wallet: listuser
                                                                .listuser[index]
                                                                .wallet,
                                                            role: listuser
                                                                .listuser[index]
                                                                .role);
                                                        manauser
                                                            .updateUser(user);
                                                        Navigator.of(context)
                                                            .popUntil((route) =>
                                                                route.isFirst);
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (builder) =>
                                                                        UserManagementScreen()));
                                                      }
                                                    },
                                                    child:
                                                        const Text("Xác Nhận")),
                                                const SizedBox(),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("Hủy"))
                                              ],
                                            );
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) => dialog);
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
                                      context: context,
                                      builder: (context) => dialog);
                                },
                              )),
                              Expanded(
                                  child: GestureDetector(
                                child: Icon(Icons.delete),
                                onTap: () {
                                  AlertDialog dialog = AlertDialog(
                                    title: Text("Cảnh Báo!"),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Text(
                                              "Bạn có muốn xóa người dùng này?")
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            final _acceptcontroller =
                                                TextEditingController();
                                            AlertDialog dialog = AlertDialog(
                                              title: Text("Xác nhận"),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Text("Nhập mật khẩu"),
                                                    TextField(
                                                      controller:
                                                          _acceptcontroller,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      if (_acceptcontroller
                                                              .text ==
                                                          userislogin
                                                              .user
                                                              .value!
                                                              .password) {
                                                        manauser.deleteUser(
                                                            listuser.listuser[
                                                                index]);
                                                        Navigator.of(context)
                                                            .popUntil((route) =>
                                                                route.isFirst);
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (builder) =>
                                                                        UserManagementScreen()));
                                                      }
                                                    },
                                                    child:
                                                        const Text("Xác Nhận")),
                                                const SizedBox(),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("Hủy"))
                                              ],
                                            );
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) => dialog);
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
                                      context: context,
                                      builder: (context) => dialog);
                                },
                              ))
                            ],
                          )),
              );
            }),
      ),
    );
  }
}
