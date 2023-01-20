import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppBar extends StatelessWidget {
  const AppBar(
      {super.key,
      required Text title,
      required IconButton leading,
      required bool centerTitle,
      required double toolbarHeight,
      required double elevation,
      required MaterialColor backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Support",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
      ),
      leading: IconButton(
        icon: const Icon(Icons.keyboard_return_sharp),
        tooltip: 'Return Back Icon',
        onPressed: () {},
      ),
      centerTitle: true,
      toolbarHeight: 60.2,
      elevation: 5.00,
      backgroundColor: Colors.orange,
    );
  }
}
