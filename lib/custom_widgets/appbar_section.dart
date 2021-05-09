import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarSection extends StatelessWidget implements PreferredSizeWidget{
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build (BuildContext context){
    return AppBar(
      title: Text('Dog Adviser',
      style: GoogleFonts.elMessiri()),
    );
  }

}