import 'package:chatapp/ViewScreen/Login/login.dart';
import 'package:chatapp/ViewScreen/sloia.dart';
import 'package:chatapp/calculator.dart';
import 'package:chatapp/slot.dart';
import 'package:chatapp/takeawaymenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Takeawaymenu(),

    );
  }
}
