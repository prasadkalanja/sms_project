import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_project/first.dart';
import 'package:sms_project/model/Result.dart';
import 'package:sms_project/student/ViewResult.dart';
import 'package:sms_project/student/View_attendance.dart';
import 'package:sms_project/student/academic_cal.dart';
//import 'package:sms_project/student/fees.dart';
import 'package:sms_project/student/login.dart';
//import 'package:sms_project/student/result.dart';
import 'package:sms_project/student/student_profile.dart';
import '../admin/login.dart';
import '../admin/managestd.dart';
import 'package:sms_project/admin/manageteacher.dart';
import 'package:http/http.dart'as http;
import 'package:sms_project/model/Fees.dart';
import '../model/Env.dart';
import '../model/student.dart';
import 'View_Fees.dart';

class Studentzone extends StatefulWidget {

  final String? name;
  Studentzone({this.name});
  @override
  _StudentzoneState createState() => _StudentzoneState();
}

class _StudentzoneState extends State<Studentzone> {
  final ScaffoldKey=GlobalKey<_StudentzoneState>();
  late Future<List<student>>students;
  late Future<List<Fees>>fee;
  // String? students;
  String? name;
 // late Future<List>data;
  var data;
  var fdata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.name;
    print(widget.name);
    data = getStudentList();
    fdata=getFees();
  }
    Future<List<student>>getStudentList() async{
    //final  url = 'http://192.168.31.45/sm_system/student_list.php';
    final  response = await http.get(Uri.parse("${Env.URL_PREFIX}/student_list.php"));
// final response=await http.get("{$Env.URL_PREFIX}/student_list.php");

    final items=json.decode(response.body).cast<Map<String,  dynamic>>();
    List<student>students=items.map<student>((json){
      return student.fromJson(json);
    }).toList();

    for(int i=0;i<=students.length;i++)
    {
      if(students[i].student_name==name)
      {
        data=students[i];

      }
    }

    return data;

  }

  Future<List<Fees>>getFees() async{
    //final  url = 'http://192.168.31.45/sm_system/student_list.php';
    final  response = await http.get(Uri.parse("${Env.URL_PREFIX}/Fees_list.php"));
// final response=await http.get("{$Env.URL_PREFIX}/student_list.php");

    final items=json.decode(response.body).cast<Map<String,  dynamic>>();
    List<Fees>fee=items.map<Fees>((json){
      return Fees.fromJson(json);
    }).toList();

    for(int i=0;i<=fee.length;i++)
    {
      if(fee[i].student_name==name)
      {
        fdata=fee[i];

      }
    }

    return fdata;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
   key: ScaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StudentLogin()));
            },
            child: Icon(Icons.arrow_back, size: 30,),
          ),
          backgroundColor: Colors.greenAccent[400],
          centerTitle: true,
          title: Text('STUDENT ZONE', style: TextStyle(fontSize: 20),
          ),
          actions: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>First()));
            },
                icon: Icon(Icons.logout, color: Colors.white,)),
          ],
        ),
      ),
      body:
      Center(
        child: Container(

          padding: EdgeInsets.only(top: 100, left: 20, right: 20),
          child: GridView.count(
            crossAxisSpacing: 20,
            mainAxisSpacing: 50,
            crossAxisCount: 2,
            // padding: EdgeInsets.all(30),

            scrollDirection: Axis.vertical,
            children: [
              Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white60,
                child: Container(

                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => Calender()));
                    },
                    child: Text('Calendar', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/S_CALENDER.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Card(
                // color: Colors.white,
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white60,
                child: Container(
                  child: InkWell(
                    onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAttendance(name: name,)));
                    },
                    child: Text('Attendance', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/STUDENT_A.png'),
                        fit: BoxFit.cover,
                      )
                  ),
                ),

              ),
              Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white60,
                child: Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => View_Result(name:name.toString())));
                    },
                    child: Text('Result', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/S_RESULT.png'),
                      )
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white60,
                child: Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => VFees(getfee:fdata)));
                    },
                    child: Text('Fees', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/S_FEES.png'),
                      )
                  ),
                ),
              ),

              Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white60,
                child: Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => StudentProfile(profile: data,)));
                    },
                    child: Text('Profile', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/STUDENT_P.png'),
                      )
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white60,
                child: Container(
                  child: InkWell(
                    onTap: () {

                    },
                    child: Text('Exam', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/exam.jpg'),
                      )
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
