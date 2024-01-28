import 'package:flutter/material.dart';

Drawer sideDrawer() {
  List<String> captionsUpper = [
    'Data Generated',
    'DB Created',
    'Table Created',
    'Data Saved to DB'
  ];
  List<String> captions = [
    'Data Generated',
    'DB Created',
    'Table Created',
    'Data Saved to DB'
  ];
  List<String> commandsUpper = [
    'Generate data',
    'Create DB',
    'Create Table',
    'Save data to DB'
  ];
  List<String> commandsLower = [
    'Delete data',
    'Delete DB',
    'Delete Table',
    'Get data from DB'
  ];

  List<bool> status = List.generate(captions.length, (index) => false);
  //status[2] = true;

  var img1 = Container(
      color: Colors.white.withOpacity(0),
      width: 40,
      height: 40,
      child: const Image(image: AssetImage('assets/icons/trans_right.png')));

  var img2 = Container(

      //opacity: 1.0,
      color: Colors.white.withOpacity(0),
      width: 40,
      height: 40,
      child: const Image(image: AssetImage('assets/icons/trans_wrong.png')));

  Card getCard(int index) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: Colors.lime,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: 160,
                  child: ElevatedButton(
                      onPressed: () {}, child: Text(commandsUpper[index])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: 160,
                  child: ElevatedButton(
                      onPressed: () {}, child: Text(commandsLower[index])),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(children: [
              Text(
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  captions[index]),
              status[index] == true ? img1 : img2,
            ]),
          )
        ],
      ),
    );
  }

  // var ch = {for ( int i=0 ; i<captions.length; i++){ Text('$i')}};

  return Drawer(
    width: 340,
    child: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...{for (int i = 0; i < captions.length; i++) getCard(i)}
        ],
      ),
    ),
  );
}
