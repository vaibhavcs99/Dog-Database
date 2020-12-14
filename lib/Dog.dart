import 'package:flutter/material.dart';

class Dog {

  // int id;
  String name;
  int age;

  Dog( this.name, this.age);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();

    // map['id'] = id;
    map['name'] = name;
    map['age'] = age;

    return map;
  }

  Map<String, dynamic> mapToList(Map map) {
    // this.id = map['id'];
    this.name = map['name'];
    this.age = map['age'];
  }
}
