import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle2.dart';
import 'package:flutter_dog_adviser/models/food/food.dart';
import 'package:flutter_dog_adviser/models/food/food_repository.dart';
import 'package:get_it/get_it.dart';

import 'food_details.dart';

class FoodList extends StatefulWidget {
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList>{
  FoodRepository _foodRepository = GetIt.I.get<FoodRepository>();
  List<Food> _foods = [];
  int _selectedIndex = 1;


  @override
  void initState() {
    super.initState();
    _loadAllFoods();
  }

  _loadAllFoods() async {
    final foods = await _foodRepository.getAllFoods();
    setState(() => _foods = foods);
  }

  _loadAllRawFoods() async {
    final rawFoods = await _foodRepository.getAllRawFoods();
    setState(() => _foods = rawFoods);
  }

  _loadAllFormulaFoods() async {
    final formulaFoods = await _foodRepository.getAllFormulaFoods();
    setState(() => _foods = formulaFoods);
  }

  void _onItemTapped(int index) async {
      _selectedIndex = index;
      if(index == 0) {
        _loadAllRawFoods();
      }else if(index == 1){
        _loadAllFoods();
      }else{
        _loadAllFormulaFoods();
      }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarSection("Dog Food List"),

      drawer: SafeArea(
        child: DrawerSection(),
      ),

      body:  ListView.builder(
          itemCount: _foods.length,
          itemBuilder: (context, index) {
            final food = _foods[index];
            return
              Card(
                child: ListTile(
                  title: TextSubtitle(food.foodName),
                  subtitle: TextSubtitle2(food.foodType),
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FoodDetails(foodItem: food,))
                    );
                  },
                ),
              );
          }
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Raw food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ballot ),
            label: 'All food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_rounded),
            label: 'Formula food',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        backgroundColor: Colors.green,
      ),
    );
  }
}