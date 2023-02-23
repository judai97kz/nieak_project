import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:nieak_project/Respositories/add_shoes.dart';
import 'package:nieak_project/Respositories/create_brandlist.dart';
import 'package:nieak_project/Respositories/user_database.dart';
import 'package:nieak_project/model/user_model.dart';
import 'package:nieak_project/model_view/brand_modelview.dart';
import 'package:nieak_project/screen/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AddShoes allShoes = AddShoes();
  final CreatBrandList cl = CreatBrandList();
  final getbrand = Get.put(BrandModelView());
  Future<void> add_admin() async {
    User admin = User(username: 'admin972001', password: 'admin972001', name: 'Admin_Judai', phone: '0367989659', address: '', idcart: 'admin', wallet: 999999999999999, role: 1);
    await UserDatabaseHelper.addUser(admin);
  }
  Future<void> copyDatabase() async {
    // Lấy đường dẫn tới thư mục database trên thiết bị Android
    String databasesPath = await getDatabasesPath();
    String path = '$databasesPath/images.db';

    // Kiểm tra xem file SQLite đã tồn tại chưa
    bool isExist = await databaseExists(path);
    if (isExist) {
      print('File SQLite đã tồn tại');
      return;
    }

    // Copy file SQLite từ assets vào thư mục database trên thiết bị
    ByteData data = await rootBundle.load('assets/databases/images.db');
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);
    print('Đã copy file SQLite vào thư mục database trên thiết bị');
  }
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    copyDatabase();
    cl.create();
    getbrand.getBrand();
    allShoes.addShoes();
    CheckAuto(context);
    add_admin();
  }

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}

// ignore: non_constant_identifier_names
Future<bool> CheckAuto(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final String? username = prefs.getString('username');
  final String? password = prefs.getString('password');
  if (username != null && password != null) {
    // ignore: use_build_context_synchronously
    UserDatabaseHelper.getAllUser(username, password, context);
    return true;
  }
  return false;
}
