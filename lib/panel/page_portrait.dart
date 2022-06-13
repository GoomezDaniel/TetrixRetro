import 'package:flutter/material.dart';
import 'package:tetris/panel/screen.dart';
import 'package:tetris/panel/status_panel.dart';

class PagePortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width - 20;

    return Scaffold(
      backgroundColor: Color(0xff9ead86),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Stack(children: [
              Screen(width: screenW),
              InfoButton(),
            ]),
          ),
        ),
      ),
    );
  }
}
