import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/models/dog/dog.dart';
import 'package:flutter_dog_adviser/models/dog/dog_repository.dart';
import 'package:get_it/get_it.dart';

import 'dog_details.dart';

class DogList extends StatefulWidget {
  _DogListState createState() => _DogListState();
}

class _DogListState extends State<DogList>{
  DogRepository _dogRepository = GetIt.I.get();
  List<Dog> _dogs = [];

  @override
  void initState() {
    super.initState();
    _loadDogs();
  }

  _loadDogs() async {
    final dogs = await _dogRepository.getAllDogs();
    setState(() => _dogs = dogs);
  }

  _addDog() async {
    String name ="Yorkshire Terrier";
    String nation ="England";
    String tags ="Friendly, Smart";

    String status ="Life span:	13 - 16 years\nColor:		tan, black, grey\nHeight:		20 - 23 cm\nWeight:	2 - 3.5 kg";
    String info ="The Yorkshire Terrier \(often shortened as Yorkie\) is one of the smallest dog breeds of the terrier type, and of any dog breed. The breed developed during the 19th century in Yorkshire, England. Yorkshire Terriers are very playful and energetic dogs. Many people who have a Yorkie as a pet have two, because they often have separation anxiety when left alone. Though small, the Yorkshire Terrier is active, very protective, curious, and fond of attention. They are also an easy dog breed to train. This results from their own nature to work without human assistance.";

    final newDog = Dog(dogName: name, dogImage: "assets/images/yorkshire_terrier.jpg", dogNation: nation,
        dogStatistics: status, dogInfo: info, dogTags: tags);
    await _dogRepository.insertDog(newDog);

    _loadDogs();
  }

  _deleteDog(Dog dog) async {
    await _dogRepository.deleteDog(dog.dogId);
    _loadDogs();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarSection(),

      drawer: DrawerSection(),

      body:  ListView.builder(
        itemCount: _dogs.length,
        itemBuilder: (context, index) {
          final dog = _dogs[index];
          return ListTile(
            title: Text(dog.dogName),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteDog(dog),
              ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DogDetails(dog_item: dog,))
              );
            },
            );
          }
      ),

      floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: _addDog,
      ),
    );
  }
}