import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSection extends StatelessWidget {
  final String _title;
  final String _subtitle;
  final String _subtitle2;
  final String _body;
  final String _foot;
  static const double _hPad = 16.0;

  TextSection(this._title, this._subtitle, this._subtitle2, this._body, this._foot);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(_hPad, 8.0, _hPad, 0.0),
          child: Text(
            _title,
            style: GoogleFonts.elMessiri(
              textStyle: Theme.of(context).textTheme.headline3,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(_hPad, 0.0, _hPad, 4.0),
          child: Text(
            _subtitle,
            style: GoogleFonts.elMessiri(
              textStyle: Theme.of(context).textTheme.headline5,
              fontSize: 20,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(_hPad, 0.0, _hPad, 4.0),
          child: Text(
            _subtitle2,
            style: GoogleFonts.elMessiri(
              textStyle: Theme.of(context).textTheme.headline5,
              fontSize: 12,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(_hPad, 4.0, _hPad, 4.0),
          child: Text(
            _body,
            style: GoogleFonts.elMessiri(),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(_hPad, 32.0, _hPad, 4.0),
          child: Text(
            _foot,
            style: GoogleFonts.elMessiri(),
          ),
        ),
      ],
    );
  }
}
