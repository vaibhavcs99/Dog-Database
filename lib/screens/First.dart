import 'package:flutter/material.dart';
import '../model/Dog.dart';
import '../model/db_helper.dart';
import 'Drawer.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text("DOG"),
      ),
      body: bodyWidget(),
      drawer: NewDrawer(),
    );
  }

  //Retreive Data

  Future<String> getDogNames() async {
    List<Dog> list = await dBhelper.retrieveDogs();
    List<String> names = List();

    //replaced async with then
    list.forEach((element) {
      names.add(element.name + " " + element.age.toString());
    });
    var tempList = names.toString();
    return tempList;
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

  bodyWidget() {
    var _minSpace = 5.0;
    return Padding(
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
        ]));
  }
}
