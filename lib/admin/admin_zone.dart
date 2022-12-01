import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:sms_project/admin/AddEvents.dart';
import 'package:sms_project/admin/Admin_profile.dart';
import 'package:sms_project/admin/login.dart';
import 'package:sms_project/admin/manage_student_zone.dart';
import 'package:sms_project/admin/manage_teacher_zone.dart';
import 'package:sms_project/first.dart';

import '../model/Admin.dart';
import '../model/Env.dart';

class Adminzone extends StatefulWidget {
  final String? email;
  Adminzone({this.email});
  @override
  _AdminzoneState createState() => _AdminzoneState();
}

class _AdminzoneState extends State<Adminzone> {
  String? email;
  late Future<List<Admin>>admin;
  var data;
  //int count=0;
  @override
  void initState() {
    super.initState();
    email=widget.email;
    data=getTeacherList();
  }
  Future<List<Admin>>getTeacherList() async{
    //final  url = 'http://192.168.31.45/sm_system/Teacher_list.php';
    final  response = await http.get(Uri.parse("${Env.URL_PREFIX}/admin_list.php"));
// final response=await http.get("{$Env.URL_PREFIX}/student_list.php");

    final items=json.decode(response.body).cast<Map<String,  dynamic>>();
    List<Admin>admin=items.map<Admin>((json){
      return Admin.fromJson(json);
    }).toList();
    for(int i=0;i<=admin.length;i++)
    {
      if(admin[i].email==email){
        data=admin[i];
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Adminlogin()));
            },
            child: Icon(Icons.arrow_back,size: 30,),
          ),
          backgroundColor:Colors.purple[300],
          centerTitle: true,
          title: Text('ADMIN ZONE',style: TextStyle(fontSize: 20),
          ),
          actions: [
            IconButton(onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>First()));
            },
                icon: Icon(Icons.logout,color: Colors.white,)),
          ],
        ),
      ),
      body:
      // Column(
      //              children: [
      //                Padding(
      //                    padding:const EdgeInsets.only( left: 25,right: 15,bottom: 16),
      //                child: Column(
      //                      children: [
      //                          SizedBox(height: 24,),
      //                        InkWell(
      //                          child: Row(
      //                                children: [
      //                                  InkWell(
      //                                    child:Image( "assets/images/calendar.png"),
      //                                  ),
      //                                ],
      //                          ),
      //                        ),
      //                      ],
      //                ),
      //                ),
      //
      //              ],
      // ),
      Center(
        child: Container(
          padding: EdgeInsets.only(top:100,left: 20,right: 20),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Mteacherzone()));
                    },
                    child: Text('Manage Teachers',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/M_TEACHERS.png'),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Mstudentzone()));
                    },
                    child: Text(' Manage Students',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/M_STUDENT.png'),
                      )
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Events()));
                    },
                    child: Text('Add Event',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/notification.png'),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Adminprofile(admin: data)));
                    },
                    child: Text('Profile',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),
                  ),
                  decoration: BoxDecoration(image: DecorationImage(
                    image: AssetImage('assets/images/P_ADMIN.png'),
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

