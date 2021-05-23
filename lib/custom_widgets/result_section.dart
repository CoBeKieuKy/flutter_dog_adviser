import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_body.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_foot.dart';
import 'package:flutter_dog_adviser/models/dog/dog.dart';
import 'package:flutter_dog_adviser/views/dog_details.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ResultSection extends StatelessWidget{
  String _name;
  String _confidence;
  List<Dog>  _foundDog;
  double _percentageResult;

  ResultSection(this._name, this._confidence, this._foundDog, this._percentageResult);

  @override
  Widget build (BuildContext context){
    return Card(
      color: Colors.white,

      child: Container(
        child: ListTile(
          leading: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 60,
              minHeight: 60,
              maxWidth: 60,
              maxHeight: 60,
            ),
            child: Image.asset("assets/images/util/glass.gif", fit: BoxFit.cover,),

          ),
          subtitle:
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 10, 18),
              child: new LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 200,
                animation: true,
                lineHeight: 35.0,
                animationDuration: 1000,
                percent: _percentageResult,
                center: new TextFoot("$_confidence"),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.green,
              ),
            ),

          title:
            Container(
              child: TextBody('$_name'),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DogDetails(dogItem: _foundDog[0]))
            );
          },
        ),
      ),
    );
  }
}