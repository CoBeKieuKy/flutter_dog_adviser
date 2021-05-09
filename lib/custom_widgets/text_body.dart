import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBody extends StatelessWidget{
  final String _body;
  TextBody(this._body);

  @override
  Widget build (BuildContext context){
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: Text(
        _body,
        style: GoogleFonts.elMessiri(),
      ),
    );
  }
}