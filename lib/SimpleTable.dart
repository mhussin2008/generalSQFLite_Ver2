import 'package:flutter/material.dart';
import 'package:general_sqflite_ver2/sideDrawer.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'dataClass.dart';

class SimpleTablePage extends StatefulWidget {
  const SimpleTablePage({super.key,

    //required this.user,
  }) ;

  @override
  State<SimpleTablePage> createState() => _SimpleTablePageState();
}

class _SimpleTablePageState extends State<SimpleTablePage> {
  //final User user;
  final _tstyle = const TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: generalKeys.dataTableKey,
      appBar: AppBar(
        title: Center(
            child: Text(
          'Total Records=${RecordsListClass.recordsList.length}',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        )),
      ),
      drawer: DrawerWidget(callBackFunc),
      body: HorizontalDataTable(
          leftHandSideColumnWidth: 300,
          rightHandSideColumnWidth: 100,
          isFixedHeader: true,
          headerWidgets: _getTitleWidget(),
          //isFixedFooter: true,
          //footerWidgets: _getTitleWidget(),
          leftSideItemBuilder: _generateFirstColumnRow,
          rightSideItemBuilder: _generateRightHandSideColumnRow,
          itemCount: RecordsListClass
              .recordsList.length, // myRecords.recordsList.length,

          rowSeparatorWidget: const Divider(
            color: Colors.black38,
            height: 1.0,
            thickness: 1.0,
          ),
          leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
          rightHandSideColBackgroundColor: const Color(0xFFFFFFFF)),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Name', 300),
      _getTitleItemWidget('Age', 100),
      // _getTitleItemWidget('Phone', 200),
      // _getTitleItemWidget('Register', 100),
      // _getTitleItemWidget('Termination', 200),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
      child: Text(label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 100,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      // child: Text(widget.user.userInfo[index].name),
      child: Text(
        RecordsListClass.recordsList[index].name,
        //myRecords.recordsList[index].Name,
        style: _tstyle,
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
            width: 100,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child:
                // Icon(
                //     widget.user.userInfo[index].status=='true'
                //         ? Icons.notifications_off
                //         : Icons.notifications_active,
                //     color: widget.user.userInfo[index].status=='true'
                //         ? Colors.red
                //         : Colors.green),
                // Text(widget.user.userInfo[index].status=='true' ? 'Disabled' : 'Active')

                Text(
              RecordsListClass.recordsList[index].age.toString(),
              //myRecords.recordsList[index].Age.toString(),

              style: _tstyle,
            )),

        // Container(
        //   width: 200,
        //   height: 52,
        //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        //   alignment: Alignment.centerLeft,
        //   child: Text(widget.user.userInfo[index].phone),
        // ),
        // Container(
        //   width: 100,
        //   height: 52,
        //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        //   alignment: Alignment.centerLeft,
        //   child: Text(widget.user.userInfo[index].registerDate),
        // ),
        // Container(
        //   width: 200,
        //   height: 52,
        //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        //   alignment: Alignment.centerLeft,
        //   child: Text(widget.user.userInfo[index].terminationDate),
        // ),
      ],
    );
  }

  callBackFunc() {
    print('function called ok');
    setState(() {

    });
  }
}
