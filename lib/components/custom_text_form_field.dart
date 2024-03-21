import 'package:flutter/material.dart';
import 'package:todo/my_theme.dart';

typedef Validator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  String label;
  TextInputType keyBoard;
  bool isPassword;
  TextEditingController controller;
  Validator validator;
  CustomTextFormField(
      {required this.label,
      required this.controller,
      required this.validator,
      this.keyBoard = TextInputType.text,
      this.isPassword = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(
          label: Text(label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 1, color: MyTheme.blueColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 2, color: MyTheme.blueColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 2,color: Colors.red)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 1,color: Colors.red)),

        ),
        cursorColor: MyTheme.blueColor,
        style: Theme.of(context).textTheme.bodyMedium,
        keyboardType: keyBoard,
        obscureText: isPassword,
        controller: controller,
        validator: validator,
      ),
    );
  }
}
