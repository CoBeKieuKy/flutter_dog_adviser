import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarSection extends StatelessWidget implements PreferredSizeWidget{
  String appBarName;
  AppBarSection(this.appBarName);

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build (BuildContext context){
    return AppBar(
      title: Text(appBarName,
      style: GoogleFonts.elMessiri()),
      // actions: <Widget>[
      //   IconButton(icon: Icon(Icons.search), onPressed: () {}),
      // ],
    );
  }

}