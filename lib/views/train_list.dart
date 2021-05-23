import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/controller/train/train_controller.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle2.dart';
import 'package:flutter_dog_adviser/models/train/train.dart';

import 'train_details.dart';

class TrainList extends StatefulWidget {
  _TrainListState createState() => _TrainListState();
}

class _TrainListState extends State<TrainList>{
  List<Train> _trains = [];
  TrainController _trainListController = TrainController();

  @override
  void initState() {
    super.initState();
    _loadAllTrains();
  }

  _loadAllTrains() async {
    final trains = await _trainListController.getAllTrains();
    setState(() => _trains = trains);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarSection("Training Dog"),

      drawer: SafeArea(
        child: DrawerSection(),
      ),

      body:  ListView.builder(
          itemCount: _trains.length,
          itemBuilder: (context, index) {
            final train = _trains[index];
            return
              Card(
                child: ListTile(
                  title: TextSubtitle(train.trainName),
                  subtitle: TextSubtitle2(train.trainFor),
                  // trailing: IconButton(
                  //   icon: Icon(Icons.delete),
                  //   onPressed: () async{
                  //     await _trainListController.deleteTrain(train);
                  //     _loadAllTrains();
                  //   },
                  // ),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 80,
                      minHeight: 80,
                      maxWidth: 80,
                      maxHeight: 80,
                    ),
                    child: Image.asset(train.trainImage, fit: BoxFit.cover),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TrainDetails(trainItem: train,))
                    );
                  },
                ),
              );
          }
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () async{
      //     await _trainListController.addTrain();
      //     _loadAllTrains();
      //   },
      // ),
    );
  }
}