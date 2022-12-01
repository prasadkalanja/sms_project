import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_project/model/Attendance.dart';

import '../model/Env.dart';
import 'package:http/http.dart'as http;

class ADetail extends StatefulWidget {
  final Attendance attend;
  ADetail({ required this.attend});
  @override
  _ADetailState createState() => _ADetailState();
}

class _ADetailState extends State<ADetail> {
  void deleteA(context)async{
    //final  url = 'http://192.168.31.45/sm_system/student_delete.php';
    await http.post(Uri.parse("${Env.URL_PREFIX}/delete_attend.php"),
      body:{
        'id':widget.attend.student_name.toString(),
      },
    );
    // Navigator.pop(context);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
  void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Are you sure you want to delete this?'),
          actions: <Widget>[
            ElevatedButton(
              child: Icon(Icons.cancel),
              // color: Colors.red,
              // textColor: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Icon(Icons.check_circle),
              // color: Colors.blue,
              //               // textColor: Colors.white,
              onPressed: () => deleteA(context),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => confirmDelete(context),
          ),
        ],
      ),
      body: Container(
        height: 270.0,
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Name : ${widget.attend.student_name}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "class : ${widget.attend.classs}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "subject : ${widget.attend.subject}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Status : ${widget.attend.status}",
              style: TextStyle(fontSize: 20),
            ),

          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.edit),
      //   onPressed:()=> Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (BuildContext context) => Edit(students: widget.students),
      //     ),
      //   ),
      // ),
    );
  }
}
