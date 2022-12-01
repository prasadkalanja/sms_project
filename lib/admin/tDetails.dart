import 'package:flutter/material.dart';
import 'package:sms_project/admin/tEdit.dart';

import '../model/Env.dart';
import '../model/teacher.dart';
import 'package:http/http.dart'as http;
class Tdetails extends StatefulWidget {
  final Teacher teacher;
  Tdetails({required this.teacher});
  @override
  _TdetailsState createState() => _TdetailsState();
}

class _TdetailsState extends State<Tdetails> {
  void deleteTeacher(context)async{
    //final  url = 'http://192.168.31.45/sm_system/teacher_delete.php';
    await http.post(Uri.parse("${Env.URL_PREFIX}/teacher_delete.php"),
      body:{
        'id':widget.teacher.id.toString()
      },
    );
     Navigator.pop(context,false);
    // Navigator.of(context)
    //     .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
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
              // textColor: Colors.white,
              onPressed: () => deleteTeacher(context),
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
              "Name : ${widget.teacher.teacher_name}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "Email : ${widget.teacher.email}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Subject : ${widget.teacher.teaching_subject}",
              style: TextStyle(fontSize: 20),
            ),

            Text(
              "Experience : ${widget.teacher.experience}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed:()=> Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Tedit(teacher: widget.teacher),
          ),
        ),
      ),
    );
  }
}

