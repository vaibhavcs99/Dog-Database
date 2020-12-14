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
  TextEditingController controller = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DOG"),
      ),
      body: ListView(children: [
        Text(_changedData),
        RaisedButton(
            child: Text("add"),
            onPressed: () async {
              await dBhelper.insertDog(Dog("tommy", 21));
              setState(() {
                debugPrint("********************");
                getDogNames().then((value) => _changedData = value);
              });
            }),
        TextField(
            controller: controller,
            decoration: InputDecoration(labelText: "Data to Delete")),
        RaisedButton(
          child: Text("delete"),
          onPressed: () {
            int number = int.parse(controller.text);
            if (number != null) dBhelper.deleteDogs(number);
          },
        )
      ]),
    );
  }

  Future<String> getDogNames() async {
    List<Dog> list = await dBhelper.retrieveDogs();
    List<String> names = List();
    list.forEach((element) {
      names.add(element.name + " " + element.age.toString());
    });
    var list2 = names.toString();
    return list2;
  }
}
