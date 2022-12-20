import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_crud_test/view/home.dart';

void main() {
  runApp(const MyApp());
}

void dismissKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomePage(),
    );
  }
}

