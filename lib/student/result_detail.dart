import 'package:flutter/material.dart';

import '../model/Result.dart';
import 'ViewResult.dart';

class ResultDetails extends StatefulWidget {
  final Result marks;
  ResultDetails({required this.marks});

  @override
  _ResultDetailsState createState() => _ResultDetailsState();
}

class _ResultDetailsState extends State<ResultDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            leading: InkWell(
              onTap: ()=>Navigator.pop(context, false),
              child: Icon(Icons.arrow_back, size: 30,),
            ),
            title: Text(
              'Result',
              style: TextStyle(fontSize: 20),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor:  Color(0xff002c51),
          ),
        ),
      body: Container(
        height: 500,
       width: 700,
       padding: const EdgeInsets.only(top: 10,left: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Card(color: Colors.white12,
             // elevation: 10,
              //shadowColor: Colors.black,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                  children:[
                    Text(
                          "Name : ${widget.marks.student_name}",

                          style: TextStyle(fontSize: 20),
                    ),
            Padding(
                  padding: EdgeInsets.all(10),
            ),
            Text(
                  "Exam Name : ${widget.marks.exam_name}",
                  style: TextStyle(fontSize: 20),
            ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
            Text(
                  "Total Marks : ${widget.marks.total_marks}",
                  style: TextStyle(fontSize: 20),
            ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
            Text(
                  "Obtained Marks : ${widget.marks.obtained_marks}",
                  style: TextStyle(fontSize: 20),
            ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
            Text(
                  "Percentage: ${widget.marks.percentage}",
                  style: TextStyle(fontSize: 20),
            ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
            Text(
                  "Result : ${widget.marks.result}",
                  style: TextStyle(fontSize: 20),
            ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                  ],
            ),
                ],
              ),

    ),
          ],
        ),
      ),

    );
  }
}
// class rDetailspage extends StatefulWidget {
//   @override
//   _rDetailspageState createState() => _rDetailspageState();
// }
//
// class _rDetailspageState extends State<rDetailspage> {
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }

