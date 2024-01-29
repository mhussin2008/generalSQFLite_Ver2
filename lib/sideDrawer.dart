import 'package:flutter/material.dart';
import 'package:general_sqflite_ver2/dataClass.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget() : super(key: generalKeys.drawerKey);

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () {
                          if (index == 0) {
                            generalKeys.statusNotifier[0].value = true;
                            generalKeys.dataTableKey.currentState!.setState(() {
                              status[0] = true;
                              RecordsListClass.generateData();
                            });
                          }
                        },
                        child: Text(commandsUpper[index])),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    width: 160,
                    child: ElevatedButton(
                        onPressed: () {
                          if (index == 0) {
                            generalKeys.statusNotifier[0].value = false;

                            generalKeys.dataTableKey.currentState!.setState(() {
                              status[0] = false;

                              RecordsListClass.recordsList.clear();
                            });
                          }
                        },
                        child: Text(commandsLower[index])),
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

                ValueListenableBuilder(
                    valueListenable: generalKeys.statusNotifier[index],
                    builder: (context, snapshot, child) {
                      print(
                          'im here ${generalKeys.statusNotifier[index].value}');
                      return generalKeys.statusNotifier[index].value
                          ? img1
                          : img2;
                    }),
                //status[index] == true ? img1 : img2,
              ]),
            )
          ],
        ),
      );
    }

    Widget buildDrawer() {
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

    return buildDrawer();
  }

  //status[2] = true;

  // var ch = {for ( int i=0 ; i<captions.length; i++){ Text('$i')}};
}
