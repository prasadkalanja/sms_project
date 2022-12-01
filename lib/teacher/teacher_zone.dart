import 'dart:convert';
//import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:sms_project/admin/login.dart';
import 'package:sms_project/first.dart';
// import 'package:sms_project/model/Table_student.dart';
// import 'package:sms_project/model/student.dart';
import 'package:sms_project/teacher/View_salary.dart';
import 'package:sms_project/teacher/login.dart';
//import 'package:sms_project/teacher/salary.dart';
import 'package:sms_project/teacher/teacher_profile.dart';
import 'package:http/http.dart'as http;

import '../model/Env.dart';
import '../model/teacher.dart';
import '../student/academic_cal.dart';
import 'Attendance.dart';

class Teacherzone extends StatefulWidget {
  final String? name;
  Teacherzone({this.name});
  @override
  _TeacherzoneState createState() => _TeacherzoneState();
}

class _TeacherzoneState extends State<Teacherzone> {
  String? name;
  late Future<List<Teacher>>teacher;
  var data;
  //int count=0;
  @override
  void initState() {
    super.initState();
    name=widget.name;
    data=getTeacherList();
  }
  Future<List<Teacher>>getTeacherList() async{
    //final  url = 'http://192.168.31.45/sm_system/Teacher_list.php';
    final  response = await http.get(Uri.parse('${Env.URL_PREFIX}/teacher_list.php'));
//final response=await http.get("{$Env.URL_PREFIX}/student_list.php");

    final items=json.decode(response.body).cast<Map<String,  dynamic>>();
    List<Teacher>teacher=items.map<Teacher>((json){
      return Teacher.fromJson(json);
    }).toList();
    for(int i=0;i<=teacher.length;i++)
      {
        if(teacher[i].email==name){
          data=teacher[i];
        }
      }
    // count=students.length;
    // var data=students[count];
    // print(students[0].phone_no);
    //  // print(students[1].phone_no);
    // print(students[0].address);
    // print(students[0].id);
    return data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // drawer: Drawer(
      //       child: ListView(
      //       children: [
      //         UserAccountsDrawerHeader(
      //           decoration: BoxDecoration(color: Colors.black),
      //           accountName: Text('PRASADA KALANJA'),
      //           accountEmail:Text('prasadkalanja@gmail.com'),
      //           currentAccountPicture: CircleAvatar(backgroundColor: Colors.amber,
      //             child: Text('P',style: TextStyle(fontSize: 40.0),
      //             ),
      //           ),
      //         ),
      //         ListTile(
      //           onTap: (){
      //             Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
      //           },
      //           leading:  Icon(Icons.logout),title: Text('LogOut'),
      //         ),
      //       ],
      //       ),
      // ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherLogin()));
            },
            child: Icon(Icons.arrow_back,size: 30,),
          ),
          backgroundColor: Colors.greenAccent[200],
          centerTitle: true,
          title: Text('TEACHER ZONE',style: TextStyle(fontSize: 20),
          ),
          actions: [
            IconButton(onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>First()));},
                icon: Icon(Icons.logout,color: Colors.white,)),
          ],
        ),
      ),
      body:
      Center(
        child: Container(
          child: GridView.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            crossAxisCount:2,
            // padding: EdgeInsets.all(30),
            scrollDirection: Axis.vertical,
            children: [
              Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white60,
                child: Container(
                  // color: Colors.transparent,
                  // child: ListTile(onTap: (){
                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>mstudent()));
                  // },
                  // ),
                  child: InkWell(
                    onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Calender()));
                    },
                    child: Text('Schedule',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/S_CALENDER.png'),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white60,
                // color: Colors.white,
                child: Container(
                  child: InkWell(
                    onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TakeAttendance(data:data)));
                    },
                    child: Text('Attendance',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/STUDENT_A.png'),
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>VSalary(tname: data,)));
                    },
                    child: Text('Salary',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/T_SALARY.png'),
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Teacherprofile(teacher: data,)));
                    },
                    child: Text('Profile',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(image: DecorationImage(
                        image: AssetImage('assets/images/TEACHER_P.png'),
                      )
                  ),
                ),
              ),
              // Card(
              //   child: Container(
              //     child: InkWell(
              //       onTap: (){
              //
              //       },
              //       child: Text('Exam',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
              //     ),
              //     decoration: BoxDecoration(
              //         image: DecorationImage(
              //           image: AssetImage('assets/images/exam.jpg'),
              //         )
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

