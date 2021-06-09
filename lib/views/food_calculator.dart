import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/controller/food/food_controller.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/pie_chart.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle2.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_title.dart';
import 'package:flutter_dog_adviser/models/food/food.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodCalculator extends StatefulWidget {
  _FoodCalculatorState createState() => _FoodCalculatorState();
}

class _FoodCalculatorState extends State<FoodCalculator>{
  List<Food> _foods = [];
  List<Food> _list = [];
  double calories=0, carbs=0, fats=0, proteins=0;
  final HashMap<String, double> _foodQty = new HashMap<String, double>();
  Food _selectedFood;
  List<DropdownMenuItem<Food>> _dropdownMenuItems;
  FoodController _foodListController = FoodController();


  @override
  void initState() {
    super.initState();
    _loadAllFoodsAndUserDogs();
  }

  _loadAllFoodsAndUserDogs() async {
    final foods = await _foodListController.getAllFoods();
    setState(() {
      _foods = foods;
    });
    _dropdownMenuItems = buildDropdownMenuItems(_foods);
    _selectedFood = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<Food>> buildDropdownMenuItems(List foods) {
    List<DropdownMenuItem<Food>> items = List();
    for (Food food in foods) {
      if(food.foodEdible!="Inedible")
      items.add(
        DropdownMenuItem(
          value: food,
          child: Text(food.foodName),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Food selectedFood) {
    setState(() {
      _selectedFood = selectedFood;
    });
  }

  _calculate() async{
    setState(() {
      calories = 0;
      carbs = 0;
      proteins = 0;
      fats = 0;
      for (int i = 0; i < _list.length; i++) {
        calories += _list[i].calories *
            _foodQty[_list[i].foodName] / 25;
        carbs += _list[i].carbs *
            _foodQty[_list[i].foodName] / 25;
        proteins += _list[i].proteins *
            _foodQty[_list[i].foodName] / 25;
        fats += _list[i].fats *
            _foodQty[_list[i].foodName] / 25;
    }});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarSection("Food Calculator"),

      drawer: SafeArea(
        child: DrawerSection(),
      ),

      body:
        SingleChildScrollView(
          child:Container(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  child: Column(
                    children: [
                      TextTitle("Total calories (kcal)"),
                      Text(
                        calories.toString(),
                        style: GoogleFonts.elMessiri(
                          textStyle: Theme.of(context).textTheme.headline5,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellowAccent,
                        ),
                      ),
                    ],
                  ),
                  color: Colors.green,
                ),
                FoodPieChart(proteins: proteins, fats: fats, carbs: carbs,),
                Card(
                  color: Colors.white70,
                  child: Column(
                    children: [
                      TextSubtitle("Input your dog's food"),

                      Row(
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          DropdownButton(
                            value: _selectedFood,
                            items: _dropdownMenuItems,
                            onChanged: onChangeDropdownItem,
                          ),
                          ElevatedButton(
                            onPressed:() async {
                              setState(() {
                                if(!_list.contains(_selectedFood)) {
                                  _list.add(_selectedFood);
                                  _foodQty[_selectedFood.foodName] = 50;
                                  _calculate();
                                }
                              });
                            },
                            child: TextSubtitle("Add"),
                          ),
                        ],
                      ),

                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _list.length,
                        itemBuilder: (context, index) {
                          final food = _list[index];
                          return Card(
                            child: Dismissible(
                              key: Key(food.foodName),
                              background: Container(color: Colors.green),
                              onDismissed: (direction) {
                                setState(() {
                                  _list.remove(food);
                                  _calculate();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text('Remove '+food.foodName)));
                                });
                              },
                              child:
                              ListTile(
                                title: TextSubtitle(food.foodName),
                                subtitle: TextSubtitle2(_foodQty[food.foodName].toString()+" Grams"),
                                leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: 80,
                                    minHeight: 80,
                                    maxWidth: 80,
                                    maxHeight: 80,
                                  ),
                                  child: Image.asset(food.foodImage, fit: BoxFit.cover),
                                ),
                                onTap: () {
                                  setState(() {
                                    _foodQty[food.foodName]+=25;
                                    _calculate();
                                  });
                                },
                                trailing:IconButton(
                                    icon: Icon(Icons.arrow_downward),
                                    onPressed: () async {
                                      setState(() {
                                        if(_foodQty[food.foodName]-25 < 0)
                                          _foodQty[food.foodName] = 0;
                                        else {
                                          _foodQty[food.foodName] -= 25;
                                          _calculate();
                                        }
                                      });
                                    }
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}