import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFoot extends StatelessWidget{
  final String _foot;
  TextFoot(this._foot);

  @override
  Widget build (BuildContext context){
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
      child: Text(
        _foot,
        style: GoogleFonts.elMessiri(),
      ),
    );
  }
}