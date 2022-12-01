import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;

import 'package:flutter/material.dart';
import 'package:sms_project/admin/Details.dart';
import 'package:sms_project/admin/manage_student_zone.dart';

import '../model/Env.dart';
import '../model/student.dart';

class Viewstudent extends StatefulWidget {
  @override
  _ViewstudentState createState() => _ViewstudentState();
}

class _ViewstudentState extends State<Viewstudent> {
  late Future<List<student>>students;
   //late List<student>students;
  final studentListKey=GlobalKey<_ViewstudentState>();
  //int count=0;
@override
  void initState() {
    super.initState();
    students=getStudentList();
  }
  Future<List<student>>getStudentList() async{
    // final  url = 'http://192.168.31.45/sm_system/student_list.php';
    final  response = await http.get(Uri.parse("${Env.URL_PREFIX}/student_list.php"));
// final response=await http.get("{$Env.URL_PREFIX}
// /student_list.php");

    final items=json.decode(response.body).cast<Map<String,  dynamic>>();
   List<student>students=items.map<student>((json){
      return student.fromJson(json);
    }).toList();
    // count=students.length;
    // print(students[0].phone_no);
    //  // print(stude
    //  nts[1].phone_no);
    // print(students[0].address);
    // print(students[0].id);
    return students;
  }
  //List<String>Student=["prasad","rakshith","avinash"];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: studentListKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: InkWell(
            onTap: ()=>Navigator.pop(context, false),

            child: Icon(Icons.arrow_back, size: 30,),
          ),
          title: Text(
            'View Student',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xff002c51),
        ),
      ),
      body:Scrollbar(
        child:
        FutureBuilder<List<student>>(
          future: students,
          builder: (ctx, snapshot){
            //show loading spinner
            if(!snapshot.hasData) return CircularProgressIndicator();
            //render student list
            Alignment.center;
            return
            ListView.builder(
                itemCount:snapshot.data!.length,
                itemBuilder:(ctx,int index){
                   var data=snapshot.data![index];
                  // final data=snapshot.data as String;
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      trailing: Icon(Icons.view_list),
                      title: Text(
                       data.student_name!, style: TextStyle(fontSize: 20),),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(students:data)),
                        );
                      },
                    ),
                  );

                });
          },

        ),
      ),




    );
  }

}

// class Env {
//   static String URL_PREFIX = "http://192.168.3.45/sm_system";
// }
