
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../controller/homescreen_controller.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final String name;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enable;

  CustomTextField({
    super.key,
    required this.text,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType = TextInputType.text,
    this.name = "",
    this.controller,
    this.validator,
    this.inputFormatters,
    this.enable,
  });


  var homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                spreadRadius: 0.1,
                offset: const Offset(0, 1),
              )
            ]
        ),
        width: Get.width * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        margin: const EdgeInsets.only(bottom: 10, right: 3, left: 3),
        child: FormBuilderTextField(
          readOnly: enable ?? false,
          inputFormatters: inputFormatters,
          controller: controller,
          textAlign: TextAlign.left,
          name: name,
          textAlignVertical: TextAlignVertical.center,
          obscureText: inputType == TextInputType.visiblePassword,
          keyboardType: inputType,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: text,
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            border: InputBorder.none,
          ),
        ));
  }
}
