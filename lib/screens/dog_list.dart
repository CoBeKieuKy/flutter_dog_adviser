import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle2.dart';
import 'package:flutter_dog_adviser/models/dog/dog.dart';
import 'package:flutter_dog_adviser/models/dog/dog_repository.dart';
import 'package:get_it/get_it.dart';

import 'dog_details.dart';

class DogList extends StatefulWidget {
  _DogListState createState() => _DogListState();
}

class _DogListState extends State<DogList>{
  DogRepository _dogRepository = GetIt.I.get<DogRepository>();
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

  _deleteDog(Dog dog) async {
    await _dogRepository.deleteDog(dog.dogId);
    _loadDogs();
  }

  _addDog() async {
    String name ="Akita";
    String nation ="Japan";
    String tags ="Friendly, Smart";
    String info = "Akita is a large breed of dog originating from the mountainous regions of northern Japan. There are two separate varieties of Akita: a Japanese strain, commonly called Akita Inu (inu means dog in Japanese) or Japanese Akita, and an American strain, known as the Akita or American Akita. The Japanese strain comes in a narrow palette of colors, with all other colors considered atypical of the breed, while the American strain comes in all dog colors. The Akita is a powerful, independent and dominant breed, commonly aloof with strangers but affectionate with family members. As a breed, Akitas are generally hardy.";
    String status ="Life span: 10 years\nColor:  ginger, red, brindle, or white\nHeight:   64–69 cm\nWeight:   15–18 kg";
    final newDog = Dog(dogName: name, dogImage: "assets/images/akita.jpg", dogNation: nation,
        dogStatistics: status, dogInfo: info, dogTags: tags);
    await _dogRepository.insertDog(newDog);

    _loadDogs();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarSection("Dog List"),

      drawer: SafeArea(
        child: DrawerSection(),
      ),
      body:  ListView.builder(
        itemCount: _dogs.length,
        itemBuilder: (context, index) {
          final dog = _dogs[index];
          return
            Card(
                child: ListTile(
                  title: TextSubtitle(dog.dogName),
                  subtitle: TextSubtitle2(dog.dogTags),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteDog(dog),
                  ),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 80,
                      minHeight: 80,
                      maxWidth: 80,
                      maxHeight: 80,
                    ),
                    child: Image.asset(dog.dogImage, fit: BoxFit.cover),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DogDetails(dogItem: dog,))
                    );
                  },
                ),
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