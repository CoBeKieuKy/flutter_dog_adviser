import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSubtitle extends StatelessWidget{
  final String _subtitle;
  TextSubtitle(this._subtitle);

  @override
  Widget build (BuildContext context){
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0),
      child: Text(
        _subtitle,
        style: GoogleFonts.elMessiri(
          textStyle: Theme.of(context).textTheme.headline5,
          fontSize: 16,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }
}