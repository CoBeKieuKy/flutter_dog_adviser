import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Text_Subtitle2 extends StatelessWidget{
  final String _subtitle2;
  Text_Subtitle2(this._subtitle2);

  @override
  Widget build (BuildContext context){
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0.0, 16, 0),
      child: Text(
        _subtitle2,
        style: GoogleFonts.elMessiri(
          textStyle: Theme.of(context).textTheme.headline5,
          fontSize: 12,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }
}