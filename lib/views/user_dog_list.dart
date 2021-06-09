import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/controller/profile/profile_controller.dart';
import 'package:flutter_dog_adviser/controller/user_dog/user_dog_controller.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle2.dart';
import 'package:flutter_dog_adviser/models/user_dog/user_dog.dart';
import 'package:flutter_dog_adviser/views/user_dog_details.dart';

import 'user_dog_form.dart';

class UserDogList extends StatefulWidget {
  _UserDogListState createState() => _UserDogListState();
}

class _UserDogListState extends State<UserDogList>{
  List<UserDog> _userDogs = [];
  UserDogController _userDogController = UserDogController();
  ProfileController _profileController = ProfileController();

  @override
  void initState() {
    super.initState();
    _loadUserDogs();
  }

  _loadUserDogs() async {
    final dogs = await _userDogController.loadUserDogs();
    setState(() => _userDogs = dogs);
  }

  _deleteUserDog(UserDog userDog) async {
    await _profileController.deleteUserDog(userDog);
    await _userDogController.deleteUserDog(userDog);
    _loadUserDogs();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarSection("User Dogs List"),

      drawer: SafeArea(
        child: DrawerSection(),
      ),
      body:  ListView.builder(
          itemCount: _userDogs.length,
          itemBuilder: (context, index) {
            final dog = _userDogs[index];
            return
              Card(
                child: ListTile(
                  title: TextSubtitle(dog.userDogName),
                  subtitle: TextSubtitle2(dog.userDogBreed),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 80,
                      minHeight: 80,
                      maxWidth: 80,
                      maxHeight: 80,
                    ),
                    child: Image.asset(dog.userDogImage, fit: BoxFit.cover),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteUserDog(dog),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserDogDetails(dogItem: dog,))
                    );
                  },
                ),
              );
          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserDogForm()));
        },
      ),
    );
  }
}