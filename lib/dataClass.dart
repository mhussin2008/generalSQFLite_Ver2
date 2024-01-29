import 'dart:math';

import 'package:flutter/material.dart';

class generalKeys {
  static GlobalKey dataTableKey = GlobalKey();
  static GlobalKey drawerKey = GlobalKey();
  static List<ValueNotifier> statusNotifier =
      List.generate(4, (index) => ValueNotifier(false));
}

class SingleRecordClass {
  final String name;
  final int age;

  SingleRecordClass(this.name, this.age);
  SingleRecordClass.empty({this.name = '', this.age = 0});
  SingleRecordClass.byDefault({this.name = 'Ahmed', this.age = 30});
  SingleRecordClass.random()
      : name = Random().nextInt(100).toString(),
        age = Random().nextInt(100);
}

class RecordsListClass {
  static List<SingleRecordClass> recordsList = <SingleRecordClass>[];
  static generateData() {
    for (int i = 0; i < 100; i++) {
      recordsList.add(SingleRecordClass.random());
    }
  }
}
