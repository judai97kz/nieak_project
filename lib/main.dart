import 'package:flutter/material.dart';

import 'package:nieak_project/Respositories/add_shoes.dart';
import 'package:nieak_project/Respositories/user_database.dart';
import 'package:nieak_project/model/user_model.dart';
import 'package:nieak_project/screen/login_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> add_admin() async {
    User admin = User(username: 'admin972001', password: 'admin972001', name: 'Admin_Judai', phone: '0367989659', address: '', idcart: '', wallet: 999999999999999, role: 1);
    await UserDatabaseHelper.addUser(admin);
  }
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
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
