import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';

import '../../Constants/app_assets.dart';

class BottomNavBar extends StatefulWidget {
  List<Widget> screens;
  BottomNavBar({
    super.key,
    required this.screens,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

var currentIndex = 2;
final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        key: _bottomNavigationKey,
        backgroundColor: back,
        color: primaryColor,
        onTap: (index) => setState(() => currentIndex = index),
        items: const <Widget>[
          Icon(Icons.settings, size: 30, color: Colors.white),
          Icon(Icons.chat, size: 30, color: Colors.white),
          ImageIcon(AssetImage(sosLogoImage), size: 30, color: Colors.white),
          Icon(Icons.notifications, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
      ),
      body: widget.screens.elementAt(currentIndex),
    );
  }
}
