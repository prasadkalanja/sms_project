import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Salary.dart';

class SalaryDetail extends StatefulWidget {
  final Salary details;
  SalaryDetail({required this.details});
  @override
  _SalaryDetailState createState() => _SalaryDetailState();
}

class _SalaryDetailState extends State<SalaryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.delete),
          //   onPressed: () => confirmDelete(context),
          // ),
        ],
      ),
      body: Container(
        height: 270.0,
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Name : ${widget.details.teacher_name}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "Month : ${widget.details.month}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Amount : ${widget.details.amount}",
              style: TextStyle(fontSize: 20),
            ),

            // Text(
            //   "Remaining Fees : ${widget.getfee.remaining_fees}",
            //   style: TextStyle(fontSize: 20),
            // ),
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
