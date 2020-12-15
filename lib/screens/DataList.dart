import 'package:dog_db/model/db_helper.dart';
import 'package:flutter/material.dart';

class DataList extends StatefulWidget {
  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  DBhelper dBhelper = DBhelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database"),
      ),
      body: allData(),
    );
  }

  Widget allData() {
    int count = 8;
    if (dBhelper != null) {
      dBhelper.getLength().then((value) {
        count = value;
      });
    }

    final items = List<String>.generate(count, (index) => "$index");
    return ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(
            "$index",
          ));
        });
  }
}
