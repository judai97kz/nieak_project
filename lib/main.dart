import 'package:flutter/material.dart';
import 'package:nieak_project/screen/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: const LoginPage());
  }
}
