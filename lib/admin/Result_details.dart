import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_project/model/Result.dart';
import 'package:http/http.dart'as http;
import '../model/Env.dart';
import 'manage_student_zone.dart';

class ResultDetails extends StatefulWidget {
  final Result result;
  ResultDetails({required this.result});
  @override
  _ResultDetailsState createState() => _ResultDetailsState();
}

class _ResultDetailsState extends State<ResultDetails> {
  void deleteResult(context)async{
    //final  url = 'http://192.168.31.45/sm_system/result_delete.php';
    await http.post(Uri.parse("${Env.URL_PREFIX}/result_delete.php"),
      body:{
        'id':widget.result.id.toString()
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
              // textColor: Colors.white,
              onPressed: () => deleteResult(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: InkWell(
            onTap: ()=>Navigator.pop(context, false),

            child: Icon(Icons.arrow_back, size: 30,),
          ),
          title: Text(
            'RESULT DETAILS',
            style: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => confirmDelete(context),
            ),
          ],
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xff002c51),
        ),
      ),
      body: Container(
        height: 270.0,
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Name : ${widget.result.student_name}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "Exam Name : ${widget.result.exam_name}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Total Marks : ${widget.result.total_marks}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Obtained Marks : ${widget.result.obtained_marks}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Percentage: ${widget.result.percentage}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Result : ${widget.result.result}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
