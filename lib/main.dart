import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/Respositories/user_database.dart';
import 'package:nieak_project/screen/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckAuto(context);
  }

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

Future<bool> CheckAuto(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final String? username = prefs.getString('username');
  final String? password = prefs.getString('password');
  if (username != null && password != null) {
    UserDatabaseHelper.getAllUser(username, password, context);
    return true;
  }
  return false;
}
