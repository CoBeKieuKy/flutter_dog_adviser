import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';

class FoodPieChart extends StatefulWidget {
  double carbs, fats, proteins;
  FoodPieChart({Key key, this.carbs, this.fats, this.proteins})
      : super(key: key);

  @override
  _FoodPieChartState createState() => _FoodPieChartState();

}

class _FoodPieChartState extends State<FoodPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.25,
      child: Card(
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            TextSubtitle("Food nutrients info"),

            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent &&
                              pieTouchResponse.touchInput is! PointerUpEvent;
                          if (desiredTouch && pieTouchResponse.touchedSection != null) {
                            touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
                          } else {
                            touchedIndex = -1;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 0,
                      sections: showingSections(widget.proteins, widget.fats, widget.carbs)),
                ),
              ),
            ),
        ]
      ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(double proteins, double fats, double carbs) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 10.0;
      final radius = isTouched ? 130.0 : 120.0;
      double sum = proteins + fats + carbs;
      double proteinsPercentage = 0;
      double fatsPercentage = 0;
      double carbsPercentage = 0;
      if(sum>0){
        proteinsPercentage = proteins/sum.roundToDouble();
        fatsPercentage = fats/sum.roundToDouble();
        carbsPercentage = carbs/sum.roundToDouble();
      }
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: proteinsPercentage,
            title: isTouched ? proteins.toString()+"g":"Proteins",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: fatsPercentage,
            title: isTouched ? fats.toString()+"g":"Fats",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: carbsPercentage,
            title: isTouched ? carbs.toString()+"g":"Carbs",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}