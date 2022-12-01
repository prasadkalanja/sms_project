import 'package:flutter/material.dart';
import 'package:sms_project/admin/sEdit.dart';
import '../model/Env.dart';
import '../model/student.dart';
import 'package:http/http.dart'as http;

class Details extends StatefulWidget {
  final student students;
  Details({required this.students});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  void deleteStudent(context)async{
    //final  url = 'http://192.168.31.45/sm_system/student_delete.php';
    await http.post(Uri.parse("${Env.URL_PREFIX}/student_delete.php"),
    body:{
      'id':widget.students.id.toString()
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
              onPressed: () => deleteStudent(context),
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
              "Name : ${widget.students.student_name}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "Email : ${widget.students.email}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Class : ${widget.students.classs}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed:()=> Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Edit(students: widget.students),
          ),
        ),
      ),
    );
  }
}

