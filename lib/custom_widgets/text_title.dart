import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextTitle extends StatelessWidget{
  final String _title;
  TextTitle(this._title);

  @override
  Widget build (BuildContext context){
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
      child: Text(
        _title,
        style: GoogleFonts.elMessiri(
          textStyle: Theme.of(context).textTheme.headline3,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}