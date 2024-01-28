import 'package:flutter/material.dart';

Drawer sideDrawer() {
  List<String> captions = [
    'Data Generated',
    'DB Created',
    'Table Created',
    'Data Saved to DB'
  ];
  List<String> commands = [
    'Generate data',
    'Create DB',
    'Create Table',
    'Save data to DB'
  ];

  List<bool> status = List.generate(captions.length, (index) => false);

  var img1 = const SizedBox(
      width: 30,
      height: 30,
      child: Image(image: AssetImage('assets/icons/wright.png')));
  var img2 = const SizedBox(
      width: 30,
      height: 30,
      child: Image(image: AssetImage('assets/icons/wrong.png')));

  Card getCard(int index) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: ElevatedButton(
                  onPressed: () {}, child: Text(commands[index]))),
          const SizedBox(
            width: 10,
          ),
          Expanded(child: Text(captions[index])),
          const SizedBox(
            width: 10,
          ),
          status[index] == true ? img1 : img2,
        ],
      ),
    );
  }

  // var ch = {for ( int i=0 ; i<captions.length; i++){ Text('$i')}};

  return Drawer(
    width: 300,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...{for (int i = 0; i < captions.length; i++) getCard(i)}
      ],
    ),
  );
}
