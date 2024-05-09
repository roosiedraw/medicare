import 'package:flutter/material.dart';
import 'package:medicare/constants/constants.dart';

class adekleWidget extends StatelessWidget {
  adekleWidget(
      {super.key, required this.ilacAdiController, required this.labelText});

  final TextEditingController ilacAdiController;

  String labelText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
          controller: ilacAdiController,
          cursorColor: Constants().appBarColor,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                width: 3,
                color: Constants().appBarColor,
              )),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Constants().appBarColor,
              )),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Constants().appBarColor,
              )),
              labelText: labelText,
              labelStyle: TextStyle(color: Constants().appBarColor)),
        ));
  }
}
