import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Fees.dart';

class VFees extends StatefulWidget {
  final Fees getfee;
  VFees({required this.getfee});
  @override
  _VFeesState createState() => _VFeesState();
}

class _VFeesState extends State<VFees> {
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
            Text("Name : ${widget.getfee.student_name}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "Total Fees : ${widget.getfee.total_fees}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Paid Fees : ${widget.getfee.paid_fees}",
              style: TextStyle(fontSize: 20),
            ),

            Text(
              "Remaining Fees : ${widget.getfee.remaining_fees}",
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
