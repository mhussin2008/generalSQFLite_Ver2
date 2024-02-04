import 'package:flutter/material.dart';
import 'package:general_sqflite_ver2/dataClass.dart';

import 'dbHelper.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget(this.callBackFunc, {super.key}) ;
  final VoidCallback callBackFunc;
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
      'Create/Open DB',
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

    var imageTrue = Container(
        color: Colors.white.withOpacity(0),
        width: 40,
        height: 40,
        child: const Image(
            image: AssetImage('assets/icons/wright_blue_trans.png')));

    var imageFalse = Container(

        //opacity: 1.0,
        color: Colors.white.withOpacity(0),
        width: 40,
        height: 40,
        child: const Image(image: AssetImage('assets/icons/trans_wrong.png')));

    Card getCard(int index) {
      return Card(
        margin: const EdgeInsets.all(8),
        color: const Color.fromARGB(139, 126, 236, 115),
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
                        onPressed: () async {
                          if (index == 0) {
                            GeneralData.statusNotifier[0].value = true;

                            // generalKeys.dataTableKey.currentState!.setState(() {
                            //   status[0] = true;
                            //   RecordsListClass.generateData();
                            // });
                            ///  call back function
                            //status[0]=true;
                            RecordsListClass.generateData();
                            callBackFunc();


                          }
                          if (index == 1) {
                            /// create DB
                            await DbHelper.initialize();
                            if (DbHelper.dbExists == true) {
                              GeneralData.statusNotifier[1].value = true;
                            }
                            if (DbHelper.tableExists == true) {
                              GeneralData.statusNotifier[2].value = true;
                            }
                          }
                          if (index == 2) {
                            await DbHelper.createTable();
                            if (DbHelper.tableExists == true) {
                              print('created table okok');
                              GeneralData.statusNotifier[2].value = true;
                            }
                          }

                          //save to db
                          if (index == 3) {
                            //save to db
                            if (RecordsListClass.recordsList.isNotEmpty)  {
                              if(await DbHelper.addDataToTable(
                                  RecordsListClass.recordsList)==true)
                             { GeneralData.statusNotifier[3].value = true;}
                            }else(print('Empty Data Table'));
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
                        onPressed: () async {
                          if (index == 0) {
                            GeneralData.statusNotifier[0].value = false;

                            // generalKeys.dataTableKey.currentState!.setState(() {
                            //   status[0] = false;
                            //
                            //   RecordsListClass.recordsList.clear();
                            // });
                            RecordsListClass.recordsList.clear();
                            callBackFunc();

                          }
                          if (index == 1) {
                            await DbHelper.deleteDatabase();
                            GeneralData.statusNotifier[1].value = false;
                            GeneralData.statusNotifier[2].value = false;
                            GeneralData.statusNotifier[3].value = false;
                          }
                          if (index == 2) {
                            await DbHelper.deleteTable();
                            if (DbHelper.tableExists == false) {
                              GeneralData.statusNotifier[2].value = false;
                            }
                          }
                          if (index == 3) {
                            // get data from DB
                            if ((await DbHelper.readFromDatabase())==true){
                            if (RecordsListClass.recordsList.isNotEmpty) {
                              GeneralData.statusNotifier[0].value = true;
                              GeneralData.statusNotifier[3].value = true;
                            }
                            callBackFunc();
                            // generalKeys.dataTableKey.currentState!
                            //     .setState(() {});
                          }}
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
                    valueListenable: GeneralData.statusNotifier[index],
                    builder: (context, snapshot, child) {
                      // print(
                      //     'im here ${generalKeys.statusNotifier[index].value}');
                      return GeneralData.statusNotifier[index].value
                          ? imageTrue
                          : imageFalse;
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
