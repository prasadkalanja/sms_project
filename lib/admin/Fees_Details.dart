import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../model/Env.dart';
import '../model/Fees.dart';

class FDetails extends StatefulWidget {
  final Fees fees;
  FDetails({required this.fees});

  @override
  _FDetailsState createState() => _FDetailsState();
}

class _FDetailsState extends State<FDetails> {
  void deleteTeacher(context) async {
    //final url = 'http://192.168.31.45/sm_system/Fees_delete.php';
    await http.post(Uri.parse("${Env.URL_PREFIX}/Fees_delete.php"),
      body: {
        'id': widget.fees.id.toString()
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
              // primary: Colors.red,
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
              "Name : ${widget.fees.student_name}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "Total Fees : ${widget.fees.total_fees}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Paid Fees : ${widget.fees.paid_fees}",
              style: TextStyle(fontSize: 20),
            ),

            Text(
              "Remaining Fees : ${widget.fees.remaining_fees}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //       //   child: Icon(Icons.edit),
      //       //   onPressed:()=> Navigator.of(context).push(
      //       //     MaterialPageRoute(
      //       //       builder: (BuildContext context) => Tedit(teacher: widget.teacher),
      //       //     ),
      //       //   ),
      //       // ),
    );
  }
}
