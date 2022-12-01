import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'student.dart';

class TableStudent extends StatefulWidget {
  // final student StudentTable;
  // TableStudent({required this.StudentTable});
  @override
  _TableStudentState createState() => _TableStudentState();
}

class _TableStudentState extends State<TableStudent> {
  late Future<List<student>>students;
  int count=0;
  var data;
  @override
  void initState() {
    super.initState();
    data=getStudentList();
  }
  Future<List<student>>getStudentList() async{
    final  url = 'http://192.168.31.45/sm_system/student_list.php';
    final  response = await http.get(Uri.parse(url));
// final response=await http.get("{$Env.URL_PREFIX}/student_list.php");

    final items=json.decode(response.body).cast<Map<String,  dynamic>>();
    List<student>students=items.map<student>((json){
      return student.fromJson(json);

    }).toList();
    // students.indexOf()
     count=students.length;
     data=students[count];
    // print(students[0].phone_no);
    //  // print(students[1].phone_no);
    // print(students[0].address);
    // print(students[0].id);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ATTENDANCE AREA'),
        ),
        body: ListView(
          children: [
            _createDataTable()
          ],
        ),
      ),
    );
  }
  // DataTable _createDataTable() {
  //   return DataTable(columns:[
  //       DataColumn(label: Text('ID')),
  //       DataColumn(label: Text('NAME')),
  //       DataColumn(label: Text('CLASS')),
  //       DataColumn(label: Text('ACTION')),
  //       ],
  //     DataRow(cells:[
  //   //           DataCell(Text('')),
  //   //           DataCell(Text('')),
  //   //           DataCell(Text('')),
  //   //           DataCell(Icon(Icons.email)),
  //   //   ]),
  //   )
  //       .toList(),
  //
  //   );
  // }
  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }
  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('ID')),
      DataColumn(label: Text('NAME')),
      DataColumn(label: Text('CLASS')),
      DataColumn(label: Text('ACTION')),
    ];
  }
 List<DataRow> _createRows(){
    return[
    DataRow(cells:[
    DataCell(Text(data!.id)),
    DataCell(Text(data!.student_name)),
    // DataCell(Text('$students[count].classs')),
      DataCell(Text(data!.classs)),
    DataCell(Icon(Icons.email)),
    ]),
];
  }
}
