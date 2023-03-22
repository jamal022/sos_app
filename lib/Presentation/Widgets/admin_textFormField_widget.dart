import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';

class AdminTextFormField extends StatelessWidget {
  final hintText;
  final icon;
  final type;
  var textController;
  final validator;
  AdminTextFormField(
      {super.key,
      @required this.hintText,
      @required this.icon,
      @required this.type,
      required this.textController,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 10.0),
      child: TextFormField(
        controller: textController,
        keyboardType: type,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: white,
          hintText: hintText,
          prefixIcon: Icon(icon, color: black),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: orange,
            ),
          ),
        ),
      ),
    );
  }
}
