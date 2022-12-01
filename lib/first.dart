import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_project/student/login.dart';
import 'package:sms_project/teacher/login.dart';
// import 'package:sms_project/teacher/teacher_zone.dart';
// import 'student/student_zone.dart';
import 'admin/login.dart';
//import 'dart:html';
class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    //var size=MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white10,Colors.white60],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:Center(
          child: Column(
            // crossAxisAlignment:CrossAxisAlignment.center,
            children: [
              Container(
                child:Icon(Icons.reduce_capacity_sharp,size: 50,),
              ),
              Padding(padding: EdgeInsets.only(top: 250)),

            Container(
              height: 80,
              child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  color: Colors.amber,
                  margin: EdgeInsets.only(left: 30,right: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Adminlogin()));
                        },
                        title: Text("ADMIN",textScaleFactor: 1.5,textAlign: TextAlign.start),
                      ),
                    ],
                  ),
                ),
            ),
             SizedBox(height: 30,),
              Container(
                height: 80,
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  color: Colors.deepPurpleAccent,
                  margin: EdgeInsets.only(left: 30,right: 30),
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherLogin()));
                    },
                    title: Text("TEACHER",textScaleFactor: 1.5,textAlign: TextAlign.start),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                height: 80,
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  color: Colors.lightBlue,
                  margin: EdgeInsets.only(left: 30,right: 30),
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>StudentLogin()));
                    },
                    title: Text("STUDENT",textScaleFactor: 1.5,textAlign: TextAlign.start),

                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}