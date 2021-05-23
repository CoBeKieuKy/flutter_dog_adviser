import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_body.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_foot.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle2.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_title.dart';

class TextSection extends StatelessWidget {
  final String _title;
  final String _subtitle;
  final String _subtitle2;
  final String _body;
  final String _foot;

  TextSection(this._title, this._subtitle, this._subtitle2, this._body, this._foot);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Column(
            children: [
            TextTitle(_title),
            TextSubtitle(_subtitle),
            TextSubtitle2(_subtitle2),
            ],
          ),
          color: Colors.white70,

        ),

        TextBody(_body),
        Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              TextSubtitle("Stats:"),
              TextFoot(_foot),
            ],
          ),
          color: Colors.white70,
        ),
      ],
    );
  }
}
