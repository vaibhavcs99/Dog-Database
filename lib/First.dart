import 'package:flutter/material.dart';
import 'Dog.dart';
import 'db_helper.dart';

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  DBhelper dBhelper = DBhelper();
  String _changedData = 'Click Show Data';

  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _minSpace = 5.0;
    return Scaffold(
      appBar: AppBar(
        title: Text("DOG"),
      ),
      body: Padding(
          padding: EdgeInsets.all(_minSpace),
          child: ListView(children: [
            //Text view
            Padding(
              padding: EdgeInsets.all(_minSpace),
              child: Wrap(
                children: [
                  Text(_changedData),
                ],
              ),
            ),
            //ID Field
            Padding(
              padding: EdgeInsets.all(_minSpace),
              child: TextField(
                  controller: idController,
                  decoration: InputDecoration(labelText: "ID of the Dog")),
            ),

            //name Field
            Padding(
              padding: EdgeInsets.all(_minSpace),
              child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Name of the Dog")),
            ),

            //Age Field
            Padding(
              padding: EdgeInsets.all(_minSpace),
              child: TextField(
                  controller: ageController,
                  decoration: InputDecoration(labelText: "Age of the Dog")),
            ),
            Padding(
              padding: EdgeInsets.all(_minSpace),
              child: Row(
                children: [
                  //InsertButton"
                  Expanded(
                    child: RaisedButton(
                        child: Text("Add"),
                        onPressed: () {
                          insertDog();
                        }),
                  ),

                  Container(
                    width: _minSpace,
                  ),

                  //DeleteButton"
                  Expanded(
                    child: RaisedButton(
                        child: Text("Delete"),
                        onPressed: () {
                          deleteDogs();
                        }),
                  ),

                  Container(
                    width: _minSpace,
                  ),

                  //UpdateButton"
                  Expanded(
                    child: RaisedButton(
                        child: Text("Update"),
                        onPressed: () {
                          updateDog();
                        }),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(_minSpace),
                child: RaisedButton(
                    child: Text("Show Data"),
                    onPressed: () {
                      showData();
                    }))
          ])),
    );
  }

  //Retreive Data

  Future<String> getDogNames() async {
    List<Dog> list = await dBhelper.retrieveDogs();
    List<String> names = List();
    list.forEach((element) {
      names.add(element.name + " " + element.age.toString());
    });
    var list2 = names.toString();
    return list2;
  }

  void insertDog() {
    String name = nameController.text;
    int age = int.parse(ageController.text);

    dBhelper.insertDog(Dog(name, age));
    showData();
  }

  void deleteDogs() {
    int number = int.parse(idController.text);
    if (number != null) dBhelper.deleteDogs(number);
    showData();
  }

  void updateDog() {
    String name = nameController.text;
    int age = int.parse(ageController.text);
    int id = int.parse(idController.text);

    var dog = Dog(name, age);
    dog.id = id;
    dBhelper.updateDogs(dog);
    showData();
  }

  void showData() {
    setState(() {
      getDogNames().then((value) => _changedData = value);
    });
  }
}
