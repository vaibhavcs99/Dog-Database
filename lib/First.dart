import 'package:flutter/material.dart';
import 'Dog.dart';
import 'db_helper.dart';

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  DBhelper dBhelper = DBhelper();
  String _changedData = 'fnkjd';

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
            Container(
              width: 50,
              height: 150,
              child: Text(_changedData),
            ),
            //ID Field
            TextField(
                controller: idController,
                decoration: InputDecoration(labelText: "ID of the Dog")),

            //name Field
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name of the Dog")),

            //Age Field
            TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: "Age of the Dog")),
            Row(
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
                )
              ],
            ),
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

  void insertDog() async {
    await dBhelper.insertDog(Dog("tommy", 21));
    setState(() {
      debugPrint("********************");
      getDogNames().then((value) => _changedData = value);
    });
  }

  void deleteDogs() {
    int number = int.parse(idController.text);
    if (number != null) dBhelper.deleteDogs(number);
  }

  void updateDog() {}
}
