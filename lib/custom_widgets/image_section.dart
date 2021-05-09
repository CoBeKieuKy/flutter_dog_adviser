import 'package:flutter/material.dart';

class ImageSection extends StatelessWidget {
  final String _assetPath;

  ImageSection(this._assetPath);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(
          height: 250.0,
        ),
        decoration: BoxDecoration(color: Colors.grey),
        child: Image.asset(
          _assetPath,
          fit: BoxFit.cover,
        ));
  }
}
