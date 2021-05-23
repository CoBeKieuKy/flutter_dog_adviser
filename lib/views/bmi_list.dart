import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/controller/bmi/bmi_controller.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle2.dart';
import 'package:flutter_dog_adviser/models/bmi/bmi.dart';

class BMIList extends StatefulWidget {
  _BMIListState createState() => _BMIListState();
}

class _BMIListState extends State<BMIList>{
  List<BMI> _bmis = [];
  BMIController _bmiListController = BMIController();

  @override
  void initState() {
    super.initState();
    _loadDogs();
  }

  _loadDogs() async {
    final bmis = await _bmiListController.getAllBMIs();
    setState(() => _bmis = bmis);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarSection("BMI List"),

      drawer: SafeArea(
        child: DrawerSection(),
      ),
      body:  ListView.builder(
          itemCount: _bmis.length,
          itemBuilder: (context, index) {
            final bmi = _bmis[index];
            return
              Card(
                child: ListTile(
                  title: TextSubtitle(bmi.dogName),
                  subtitle: TextSubtitle2(bmi.gender),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async{
                      await _bmiListController.deleteBMI(bmi);
                      _loadDogs();
                    },
                  ),
                ),
              );
          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{
          await _bmiListController.addBMI();
          _loadDogs();
        },
      ),
    );
  }
}